<?php
class ModelShippingmotoboy extends Model
{
    public function getQuote($address)
    {
        $this->language->load('shipping/motoboy');

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int) $this->config->get('motoboy_geo_zone_id') . "' AND country_id = '" . (int) $address['country_id'] . "' AND (zone_id = '" . (int) $address['zone_id'] . "' OR zone_id = '0')");

        if (!$this->config->get('motoboy_geo_zone_id')) {
            $status = true;
        } elseif ($query->num_rows) {
            $status = true;
        } else {
            $status = false;
        }

        if ($this->cart->getSubTotal() < $this->config->get('motoboy_total')) {
            $status = false;
        }

        $endereco = $this->config->get('motoboy_partida');
        $cidade   = $this->sanitize($this->config->get('motoboy_cidade'));
        $cpk      = $this->config->get('motoboy_price');

        if ($this->config->get('motoboy_same') == "nao") {
            $dados = $this->getDistance("{$endereco}, {$cidade}", $address['address_1'] . ', ' . $address['city']);
            if (!empty($dados)) {
                $dist = (float) $dados['distancia'];
            } else {
                $status = false;
            }
        } else {
            if ($cidade == $this->sanitize($address['city'])) {
                $dados = $this->getDistance("{$endereco}, {$cidade}", $address['address_1'] . ', ' . $address['city']);
                if (!empty($dados)) {
                    $dist = (float) $dados['distancia'];
                } else {
                    $status = false;
                }
            } else {
                $status = false;
            }
        }

        if ($dist > $this->config->get('motoboy_max')) {
            $status = false;
        }

        if ($status) {
            $cost = $cpk * $dist;
        }

        $method_data = array();

        if ($status) {
            $quote_data = array();

            $quote_data['motoboy'] = array(
                'code'         => 'motoboy.motoboy',
                'title'        => $this->language->get('text_description'),
                'cost'         => $cost,
                'tax_class_id' => 0,
                'text'         => $this->currency->format($cost),
            );

            $method_data = array(
                'code'       => 'motoboy',
                'title'      => $this->language->get('text_title'),
                'quote'      => $quote_data,
                'sort_order' => $this->config->get('motoboy_sort_order'),
                'error'      => false,
            );
        }

        return $method_data;
    }

    public function getDistance($partida, $destino)
    {
        $partida   = urlencode($partida);
        $destino   = urlencode($destino);
        $distancia = 'unknown';
        $tempo     = 'unknown';
        $url       = 'http://maps.googleapis.com/maps/api/directions/xml?origin=' . $partida . '&destination=' . $destino . '&sensor=false';
        if ($data = file_get_contents($url)) {
            $xml = new SimpleXMLElement($data);
            if (isset($xml->route->leg->duration->value) and (int) $xml->route->leg->duration->value > 0) {
                $distancia = (int) $xml->route->leg->distance->value / 1000;
                $tempo     = (int) $xml->route->leg->duration->value / 60;
                return array('distancia' => $distancia, 'tempo' => $tempo);
            } else {
                return array();
            }
        } else {
            return array();
        }
    }

    public function sanitize($string)
    {
        return strtolower(preg_replace('/\s+/', ' ', trim(preg_replace('/[`^~\'"]/', null, iconv('UTF-8', 'ASCII//TRANSLIT', $string)))));
    }
}

<?php

class ControllerShippingMotoboy extends Controller
{

    private $error = array();

    public function index()
    {

        $this->language->load('shipping/motoboy');

        $this->document->setTitle($this->language->get('heading_title'));

        /**
         * Assets
         */
        $this->document->addScript('view/javascript/slick.min.js');
        $this->document->addStyle('view/stylesheet/slick/slick.css');
        $this->document->addStyle('view/stylesheet/slick/slick-theme.css');

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $this->model_setting_setting->editSetting('motoboy', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'));

        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_enabled'] = $this->language->get('text_enabled');

        $data['text_disabled'] = $this->language->get('text_disabled');

        $data['text_all_zones'] = $this->language->get('text_all_zones');

        $data['text_none'] = $this->language->get('text_none');

        $data['entry_total'] = $this->language->get('entry_total');

        $data['entry_geo_zone'] = $this->language->get('entry_geo_zone');

        $data['entry_status'] = $this->language->get('entry_status');

        $data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $data['button_save'] = $this->language->get('button_save');

        $data['button_cancel'] = $this->language->get('button_cancel');

        if (isset($this->error['warning'])) {

            $data['error_warning'] = $this->error['warning'];

        } else {

            $data['error_warning'] = '';

        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(

            'text'      => $this->language->get('text_home'),

            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),

            'separator' => false,

        );

        $data['breadcrumbs'][] = array(

            'text'      => $this->language->get('text_shipping'),

            'href'      => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'),

            'separator' => ' :: ',

        );

        $data['breadcrumbs'][] = array(

            'text'      => $this->language->get('heading_title'),

            'href'      => $this->url->link('shipping/motoboy', 'token=' . $this->session->data['token'], 'SSL'),

            'separator' => ' :: ',

        );

        $data['action'] = $this->url->link('shipping/motoboy', 'token=' . $this->session->data['token'], 'SSL');

        $data['cancel'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');

        $configs = array(
            'total',
            'partida',
            'cidade',
            'max',
            'price',
            'same',
            'geo_zone_id',
            'status',
            'sort_order',
        );

        foreach ($configs as $config) {
            if (isset($this->request->post["motoboy_{$config}"])) {

                $data["motoboy_{$config}"] = $this->request->post["motoboy_{$config}"];

            } else {

                $data["motoboy_{$config}"] = $this->config->get("motoboy_{$config}");

            }
        }

        $this->load->model('localisation/geo_zone');

        $data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

        $data['header'] = $this->load->controller('common/header');

        $data['column_left'] = $this->load->controller('common/column_left');

        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('shipping/motoboy.tpl', $data));

    }

    protected function validate()
    {
        if (!$this->user->hasPermission('modify', 'shipping/motoboy')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        return !$this->error;
    }

}

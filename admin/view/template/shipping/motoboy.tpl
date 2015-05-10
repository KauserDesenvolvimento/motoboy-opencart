<?php echo $header; ?>
<style>
    div.content:after{content: ''; display: block; clear: both; } table.form{width: 50%; float: left; } table.form .large-field{width: 250px; } div.stream-parent{width: 48%; float: right; overflow: hidden; } div.stream{width: 470px; float: right; border-right: solid 1px  #ECECEC; border-left: solid 1px  #ECECEC; border-bottom: solid 1px  #ECECEC; } .stream.slick-slider{margin-bottom: 5px; } .stream-oferecimento{width: 470px; float: right; font-size: 11px; text-align: right; text-transform: uppercase; font-weight: bold; } .stream-oferecimento span{position: relative; bottom: 6px; color: rgb(163, 163, 163); font-size: 10px; } .produto-mercado{position: absolute; bottom: 9px; right: 8px; opacity: 0.3; } .s-product{padding: 4px; background: rgb(252, 252, 252); width: 460px; box-shadow: 0 1px 1px 0px rgba(0, 0, 0, 0.21); border-top: solid 1px #ECECEC !important; transition: all .3s; position: relative; } .s-product:hover{box-shadow: inset 0px 0px 0 4px rgba(0, 0, 0, 0.04); } .s-product:first-child{border-top: 0; } .sp-image{float: left; width: 75px; min-height: 75px; vertical-align: middle; line-height: 75px; text-align: center; } .sp-image a{vertical-align: middle; display: inline-block; } .sp-image img{max-width: 75px; vertical-align: middle; max-height: 75px; } .sp-titulo a, .sp-preco a{display: block; font-size: 13px; margin-left: 10px; float: right; width: 369px; color: rgb(86, 86, 86); text-decoration: none; } .sp-titulo a{margin-top: 9px; font-weight: bold; } .sp-preco a{font-size: 14px; margin-top: 12px; font-weight: bold; } .kauser-tag{text-align: center; margin-top: 20px; } .kauser-tag img{max-width: 85%; } .clearfix:before {content: " "; display: table; } .clearfix:after {content: " "; display: table; clear: both; } .cb{clear: both; } </style>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?>
        <a href="<?php echo $breadcrumb['href']; ?>">
            <?php echo $breadcrumb['text']; ?>
        </a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
    <div class="warning">
        <?php echo $error_warning; ?>
    </div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/shipping.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons">
                <a onclick="$('#form').submit();" class="button">
                    <?php echo $button_save; ?>
                </a>
                <a href="<?php echo $cancel; ?>" class="button">
                    <?php echo $button_cancel; ?>
                </a>
            </div>
        </div>
        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div class="stream-parent">
                    <div class="stream">
                    </div>
                </div>
                <table class="form">
                    <tr>
                        <td>Endereço de partida:<span class="help">Separar por vírgulas, não é necessário complemento.</span></td>
                        <td>
                            <input type="text" name="motoboy_partida" value="<?=$motoboy_partida?>" placeholder="Rua, numero" style="width: 300px;">
                            <span class="help">Ex: Avenida Paulista, 1560</span>
                        </td>
                    </tr>
                    <tr>
                        <td>Cidade:</td>
                        <td><input type="text" name="motoboy_cidade" value="<?=$motoboy_cidade?>"></td>
                    </tr>
                    <tr>
                        <td>Distancia Maxima: <span class="help">Distancia em Kilometros</span></td>
                        <td><input type="text" name="motoboy_max" value="<?=$motoboy_max?>"></td>
                    </tr>
                    <tr>
                        <td>Apenas mesma cidade?</td>
                        <td>
                            <select name="motoboy_same">
                                <option></option>
                                <option value="sim" <?php echo ($motoboy_same=="sim") ? 'selected="selected"' : ''; ?>>Sim</option>
                                <option value="nao" <?php echo ($motoboy_same=="nao") ? 'selected="selected"' : ''; ?>>Não</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Preço por Kilometro</td>
                        <td><input type="text" name="motoboy_price" value="<?=$motoboy_price?>"></td>
                    </tr>
                    <tr>
                        <td>
                            <?php echo $entry_total; ?>
                        </td>
                        <td>
                            <input type="text" name="motoboy_total" value="<?php echo $motoboy_total; ?>" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <?php echo $entry_geo_zone; ?>
                        </td>
                        <td>
                            <select name="motoboy_geo_zone_id">
                                <option value="0">
                                    <?php echo $text_all_zones; ?>
                                </option>
                                <?php foreach ($geo_zones as $geo_zone) { ?>
                                <?php if ($geo_zone['geo_zone_id']==$motoboy_geo_zone_id) { ?>
                                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected">
                                    <?php echo $geo_zone['name']; ?>
                                </option>
                                <?php } else { ?>
                                <option value="<?php echo $geo_zone['geo_zone_id']; ?>">
                                    <?php echo $geo_zone['name']; ?>
                                </option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <?php echo $entry_status; ?>
                        </td>
                        <td>
                            <select name="motoboy_status">
                                <?php if ($motoboy_status) { ?>
                                <option value="1" selected="selected">
                                    <?php echo $text_enabled; ?>
                                </option>
                                <option value="0">
                                    <?php echo $text_disabled; ?>
                                </option>
                                <?php } else { ?>
                                <option value="1">
                                    <?php echo $text_enabled; ?>
                                </option>
                                <option value="0" selected="selected">
                                    <?php echo $text_disabled; ?>
                                </option>
                                <?php } ?>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <?php echo $entry_sort_order; ?>
                        </td>
                        <td>
                            <input type="text" name="motoboy_sort_order" value="<?php echo $motoboy_sort_order; ?>" size="1" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="kauser-tag">
            <a href="http://kauser.com.br/" target="_blank"><img src="view/image/kauser-tag.png" alt="Desenvolvido por Kauser"></a>
        </div>
    </div>
</div>

<script>
$(function() {
    $.ajax({
        url: 'http://kauser.com.br/partners/?<?=$token?>',
        type: 'get',
        dataType: 'json',
        success: function(produto){
            $('div.stream').hide(0);
            $('div.stream-oferecimento').hide(0);
            $.each(produto, function(index, val) {
                var html = '<div class="s-product clearfix">';
                html += '<div class="sp-image">';
                html += '<a href="'+val['href']+'" target="_blank"><img src="'+val['thumb']+'" alt="'+val['name']+'"></a>';
                html += '</div>';
                html += '<div class="sp-titulo"><a href="'+val['href']+'" target="_blank">'+val['name']+'</a></div>';
                html += '<div class="sp-preco"><a href="'+val['href']+'" target="_blank">'+val['price']+'</a></div>';
                html += '<a href="'+val['href']+'" target="_blank"><img src="view/image/'+val['mercado']+'-logo.png" class="produto-mercado" alt="'+val['mercado']+'"></a>';
                html += '</div>';
                $('div.stream').append(html);   
                 //$('div.stream').append(val['name'] + '<br>');
            });
            //if (html) {
                $('div.stream').show(0);
                $('div.stream-oferecimento').show(0);
                $('div.stream').slick({
                  infinite: true,
                  slidesToShow: 4,
                  slidesToScroll: 2,
                  vertical: true,
                  variableWidth: false,
                  verticalSwiping: true,
                  autoplay: true,
                  autoplaySpeed: 4500,
                  adaptiveHeight: true
                });
            //}
        }
    });
});
</script>

<?php echo $footer; ?>

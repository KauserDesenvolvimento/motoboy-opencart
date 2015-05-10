<?php echo $header; ?>
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
    </div>
</div>
<?php echo $footer; ?>

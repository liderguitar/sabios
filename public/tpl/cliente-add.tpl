<script id="cliente" type="text/html">
<div align="left" class="texto">
    <form id="cliente-form" name="cliente-form" enctype="multipart/form-data" method="post" action="">
        <input type="hidden" value="" name="id">
        <table width="700" cellspacing="0" cellpadding="0" border="0" style="margin-left:10px;">
            <tbody>
                <tr>
                    <td width="334">
                       <strong>
                            <br>
                            <input type="text" maxlength="100" value="{{nombre_comercial}}" id="nombre" name="nombre" size="30" style="float:right; margin-right:20px;">
                            Nombre Comercial: 
                        </strong>
                        
                    </td>
                    <td>
                    <br>
                        <select style="width:180px; float:right;margin-right:20px;" id="id_estado" name="id_estado">
                            <option selected="selected" value="0">
                                Pendiente de Revisión
                            </option>
                            <option value="1" selected>
                                Aceptado
                            </option>
                            <option value="2">
                                Rechazado
                            </option>
                        </select>
                        <strong>
                            Estado: 
                        </strong>                    
                    </td>
                </tr>
                <tr>
                    <td width="334">
                        <br>
                        <select style="width:180px; float:right;margin-right:20px;" id="viajante_id" name="viajante_id">
                            <option value="0" selected>
                                Cualquiera
                            </option>
    {{#viajantes}}
                            <option value="{{id}}">{{nombre}}</option>
    {{/viajantes}}    
                        </select>
                        <strong>
                            Viajante asignado: 
                        </strong>
                    </td>
                    <td>
                         <br>

                        <select style="width:180px; float:right;margin-right:20px;" name="id_categoria_cliente" id="id_categoria_cliente">
                            <option value="0">
                                Seleccione un Tipo
                            </option>
    {{#categorias}}
                            <option value="{{id}}">{{nombre}}</option>
    {{/categorias}}

                        </select>
                        <strong>
                            Tipo de Cliente 
                            <br>
                            (Lista de precios): 
                        </strong> 
                    </td>
                </tr>
                <tr>
                    <td>
                        <br>
                        <input type="text" maxlength="100" value="{{telefono1}}" size="30" style="float:right; margin-right:20px;" id="telefono1" name="telefono1">
                        <strong>
                            Teléfono 1: 
                        </strong>
                        <br>
                    </td>
                    <td>
                        <br>
                        <input type="text" maxlength="100" value="{{telefono2}}" size="30" style="float:right; margin-right:20px;" id="telefono2" name="telefono2">
                        <strong>
                            Teléfono 2: 
                        </strong>
                        <br>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br>
                        <strong>
                            <input type="text" maxlength="100" value="{{email1}}" size="30" style="float:right; margin-right:20px;" id="email" name="email">
                            Usuario Login: 
                        </strong>
                        <br>
                    </td>
                    <td>
                        <br>
                        <strong>
                            <input type="text" maxlength="100" size="30" style="float:right; margin-right:20px;" id="password" name="password">
                            Password: 
                        </strong>
                        <br>
                    </td>
                </tr>
            </tbody>
        </table>
        <br>
        <fieldset>
            <legend style="color:#006699;">
                Contacto para Avisos
            </legend>
            <table width="700" cellspacing="0" cellpadding="0" border="0" style="margin-left:10px;">
                <tbody>
                    <tr>
                        <td>
                            SMS 1:
                            <br>
                            <input type="text" maxlength="20" value="{{sms1}}" size="30" id="sms1" name="sms1">
                        </td>
                        <td>
                            SMS 2:
                            <br>
                            <input type="text" maxlength="20" value="{{sms2}}" size="30" id="sms2" name="sms2">
                        </td>
                        <td>
                            SMS 3:
                            <br>
                            <input type="text" maxlength="20" value="{{sms3}}" size="30" id="sms3" name="sms3">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            E-mail 1:
                            <br>
                            <input type="text" maxlength="100" value="{{email1}}" size="30" id="email1" name="email1">
                        </td>
                        <td>
                            E-mail 2:
                            <br>
                            <input type="text" maxlength="100" value="{{email2}}" size="30" id="email2" name="email2">
                        </td>
                        <td>
                            E-mail 3:
                            <br>
                            <input type="text" maxlength="100" value="{{email3}}" size="30" id="email3" name="email3">
                        </td>
                    </tr>
                </tbody>
            </table>

        </fieldset>
        <fieldset>
            <legend style="color:#006699;">
                Datos para envios de mercaderia
            </legend>
            <table width="700" cellspacing="15" cellpadding="0" border="0">
                <tbody>
                    <tr>
                        <td width="422" align="right">
                            <strong>
                                Empresa/s de Preferencia:
                                <input type="text" maxlength="255" value="{{empresa_de_preferencia}}" size="35" id="empresa_preferencia" name="empresa_preferencia">
                            </strong>
                        </td>
                        <td width="233" align="right">
                            <strong>
                                Asegurado:
                            </strong>
                            Si 
                            <input type="radio" value="Y" name="asegurado">
                            No
                            <input type="radio" value="N" name="asegurado">
                            <input type="text" maxlength="20" size="2" value="{{asegurado}}" id="porcentaje_asegurado" name="porcentaje_asegurado">
                            %
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            <strong>
                                Dirección para el envio:
                                <input type="text" maxlength="255" size="80" value="{{direccion_de_envio}}" id="direccion_envio" name="direccion_envio">
                            </strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            <strong>
                                Enviar a nombre/s de:
                                <input type="text" maxlength="255" size="80" value="enviar_a_nombre_de" id="enviar_nombres" name="enviar_nombres">
                            </strong>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <br>

        <fieldset>
            <legend style="color:#006699;">
                Comunicaciones
            </legend>
            No hay comentarios 
            <span onclick="abrir(591)" style="cursor:pointer;">
                (ver comunicacioes anteriores / Nueva comunicación)
            </span>
        </fieldset>
       <div id="personal">
            <span id="span_personal">
                <fieldset>
                    <legend>Personal</legend>                    
                    <table style="border-bottom:1px solid #CCCCCC;" border="0" cellpadding="0" cellspacing="10" width="693">
                        <tbody>
                            <tr>
                                <td align="right" width="319">
                                    <strong>
                                        Nombre y Apellido:				  
                                        <input name="personal_id[]" value="" type="hidden">
                                        <input name="personal_nombre[]" id="personal_nombre[]" value="" size="25" maxlength="100" type="text">
                                    </strong>
                                </td>
                                <td align="right" width="304">
                                    <strong>
                                        Cargo:				  
                                        <select name="personal_cargo[]" style="width:180px;">
                                            <option value="0">
                                                Seleccione un Cargo
                                            </option>
                                         </select>
                                    </strong>
                                </td>
                                <td align="right" width="30">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <strong>
                                        Apodo:				  
                                        <input name="personal_apodo[]" value="" size="25" maxlength="100" type="text">
                                    </strong>
                                </td>
                                <td align="right">
                                    <strong>
                                        Fecha de Nacimiento:				  
                                        <input name="personal_fecha[]" id="personal_fecha[]" value="" size="21" maxlength="100" type="text">
                                    </strong>
                                </td>
                                <td align="right">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <strong>
                                        Tel&eacute;ono Fijo:				  
                                        <input name="personal_tel1[]" value="" size="25" maxlength="100" type="text">

                                    </strong>
                                </td>

                                <td align="right">
                                    <strong>
                                        Tel&eacute;fono Movil:				  
                                        <input name="personal_tel2[]" value="" size="25" maxlength="100" type="text">
                                    </strong>
                                </td>
                                <td align="right">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <strong>
                                        E-mail:				  
                                        <input name="personal_email1[]" value="" size="25" maxlength="100" type="text">
                                    </strong>
                                </td>
                                <td colspan="2" align="right">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <strong>
                                        Observaciones:
                                    </strong>
                                    <br>

                                    <textarea name="personal_observaciones[]" cols="75" rows="4">
                                    </textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>
            </span>       
       </div>
        <input name="addpersonal" id="addpersonal" value="Nuevo" type="button">
        <br>
        <div id="sucursal">
            <fieldset>
                <legend style="color:#006699;">
                    Sucursales
                </legend>
                <br>
                <span id="span_sucursal_1">
                    <table width="684" cellspacing="6" cellpadding="0" border="0">
                        <tbody>
                            <tr>
                                <td colspan="2">
                                    <table width="667" cellspacing="0" cellpadding="" border="0">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <strong>
                                                        Número:                            
                                                        <input type="hidden" value="" ame="sucursal_id_1">
                                                        <input type="text" maxlength="100" size="20" value="" name="sucursal_nombre_1">
                                                    </strong>
                                                </td>
                                                <td>
                                                    <strong>
                                                        Pcia:
                                                    </strong>
                                                    <input type="hidden" value="0" name="sucursal_id_provincia_hidden_1">
                                                    <select style="width: 180px;" id="pais" name="pais">
                                                        <option value="0">
                                                            Seleccione un Pais
                                                        </option>
                                                    </select>       
                                                    <select style="width: 180px;" id="sucursal_id_provincia_1" name="sucursal_id_provincia_1">

                                                        <option value="0">
                                                            Seleccione una Provincia
                                                        </option>
                                                    </select>
                                                </td>
                                                <td align="right">
                                                    <strong>
                                                        Localidad:                           
                                                        <input type="text" maxlength="100" size="18" value="" name="sucursal_localidad_1">
                                                    </strong>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr style="" id="sucursal_renglon1_1">
                                <td align="right">
                                    <strong>
                                        Dirección:                      
                                        <input type="text" maxlength="100" size="35" value="" name="sucursal_direccion_1">
                                    </strong>
                                </td>
                                <td align="right">
                                    <strong>
                                        Encargados:                      
                                        <input type="text" maxlength="100" size="35" value="" name="sucursal_encargados_1">
                                    </strong>
                                </td>
                            </tr>
                            <tr style="" id="sucursal_renglon2_1">
                                <td align="right">
                                    <strong>
                                        Teléfono 1:                      
                                        <input type="text" maxlength="100" size="35" value="" name="sucursal_tel1_1">
                                    </strong>
                                </td>
                                <td align="right">
                                    <strong>
                                        Teléfono 2:                      
                                        <input type="text" maxlength="100" size="35" value="" name="sucursal_tel2_1">
                                    </strong>
                                </td>
                            </tr>
                            <tr style="" id="sucursal_renglon3_1">
                                <td colspan="2">
                                    <strong>
                                        Observaciones:
                                    </strong>
                                    <textarea rows="3" cols="70" name="sucursal_observaciones_1"></textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <span id="span_sucursal_2">
                    </span>
                </span>
            </fieldset>        
        </div>
        <input name="addsucursal" id="addsucursal" value="Nuevo" type="button">
        <!-- HASTA llega la division por tipos de producto -->
        <br>        
        <fieldset>
            <legend style="color:#006699;">
                Datos de Facturación
            </legend>
            <table width="700" cellspacing="15" cellpadding="0" border="0">
                <tbody>
                    <tr>
                        <td colspan="2">
                            <div style="float:left; width:233px;">
                                <strong>
                                    Razón Social:
                                    <br>
                                    <input type="text" maxlength="100" size="30" value="{{razon_social}}" id="razon_social" name="razon_social">
                                </strong>
                            </div>
                            <div style="float:left; width:233px;">
                                <strong>
                                    Tipo de Contribución: 
                                    <br>
                                    <select style="width:190px;" name="id_responsabilidad" id="id_responsabilidad">
                                        <option value="0">
                                            Seleccione un Tipo
                                        </option>
                                        <option selected="selected" value="4">
                                            Consumidor Final
                                        </option>
                                        <option value="2">
                                            Excento
                                        </option>
                                        <option value="3">
                                            No Responsable
                                        </option>
                                        <option value="1">
                                            Responsable Inscripto
                                        </option>
                                        <option value="5">
                                            Responsable Monotributista
                                        </option>
                                    </select>
                                </strong>
                            </div>
                            <div style="float:left; width:203px;">
                                <strong>
                                    Cuit: 
                                    <br>
                                    <input type="text" maxlength="100" size="20" value="{{cuit}}" id="cuit" name="cuit">
                                </strong>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="326" align="right">
                            <strong>
                                País:
                                <select style="width:200px;" name="id_pais" id="id_pais">
                                    <option value="0">
                                        Seleccione un País
                                    </option>
                                    <option selected="selected" value="1">
                                        Argentina (AR)
                                    </option>
                                    <option value="7">
                                        Brasil (BR)
                                    </option>
                                    <option value="3">
                                        Canada (CA)
                                    </option>
                                    <option value="4">
                                        Chile (CL)
                                    </option>
                                    <option value="5">
                                        Costa Rica (CR)
                                    </option>
                                    <option value="2">
                                        España (ES)
                                    </option>
                                    <option value="8">
                                        Mexico (MX)
                                    </option>
                                    <option value="6">
                                        Uruguay (UR)
                                    </option>
                                </select>
                            </strong>
                        </td>
                        <td width="344" align="right">
                            <strong>
                                Provincia: 
                            </strong>

                            <select style="width:200px;" name="id_provincia">
                                <option value="0">
                                    Seleccione una Provincia
                                </option>
                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <strong>
                                Localidad:
                                <input type="text" maxlength="100" size="30" value="{{localidad}}" id="localidad" name="localidad">
                            </strong>
                        </td>
                        <td align="right">
                            <strong>
                                Dirección:
                                <input type="text" maxlength="100" size="30" value="{{direccion_de_envio}}" id="direccion" name="direccion">
                            </strong>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <strong>
            Deshabilitar acceso al sistema de pedidos? 
        </strong>
        <br>
        Si
        <input type="radio" value="s" name="acceso" id="acceso">
        No
        <input type="radio" value="n" name="acceso" id="acceso" checked="checked" >
        <br>
        <div align="center">
            <br>
            <input type="submit" id="enviar" value="Guardar" name="enviar">
            <br>
        </div>
    </form>
    <br>
</div>
</script>
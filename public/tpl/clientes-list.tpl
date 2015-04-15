<script id="cliente-list" type="text/html">
<table summary="Meeting Results" id="gradient-style" style="width:100%">
    <thead>
        <tr>
            <th scope="col"><a href="">Id</a></th>
            <th scope="col"><a href="">Nombre</a></th>
            <th scope="col"><a href="">Atiende</a></th>
            <th scope="col" class="center"><a href="">Bloq</a></th>
            <th scope="col" class="center"><a href="">Borrar</a></th>	
            <th scope="col" class="center"><a href="">Editar</a></th>	

    </thead>	
    <tfoot>
        <tr>
            <td colspan="10"></td>
        </tr>
    </tfoot>		
    
        {{#data}}
        <tr>
            <td><a href="#">{{id}}</a></td>
            <td><a href="#">{{nombre_comercial}}</a></td>
            <td><a href="#"></a></td>
            <td class="center"><span class="ui-icon center"></span></td>
            <td class="center"><a href="#"><span class="ui-icon center ui-icon-closethick"></span></a></td>
            <td class="center"><a href="#" onclick="Sabios.addCliente({{id}});">Editar</a></td>
        </tr>
        {{/data}}

</table>
</script>
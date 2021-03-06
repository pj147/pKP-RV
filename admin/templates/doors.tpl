{{include file='main_pieces/header.tpl'}}
<div id="listItems" class="pagePieces">
<h1>Doors <input type="button" value="Add" onclick="modifyItem(0)" /></h1>
<fieldset style="margin-bottom:5px">
<legend><strong>Search:</strong></legend>
<form method="get">
<input type="hidden" name="page" value="{{$smarty.get.page}}" />
<table width="100%" cellpadding="5" cellspacing="1">
<tr>
	<td><strong>Expression:</strong></td>
	<td><input type="text" name="expression" value="{{$smarty.get.expression|default:''}}" /></td>
	<td><strong>Manufacturer:</strong></td>
	<td><select name="manufacturer">
    <option value="">--choose--</option>
    {{foreach $manufacturers as $n}}
    <option value="{{$n.Id}}"{{if isset($smarty.get.manufacturer) && $smarty.get.manufacturer==$n.Id}} selected="selected"{{/if}}>{{$n.Name}}</option>
    {{/foreach}}
    </select></td>
</tr>
<tr>
	<td align="center" colspan="4"><input type="submit" value="Search" /> <input type="button" value="Reset" onclick="window.location='?page={{$smarty.get.page}}'" /></td>
</tr>
</table>
</form>
</fieldset>
<div class="paginare">
Pages: {{section loop=$pagini name=pagini}} <a href="{{$linkwcp}}&pg={{$smarty.section.pagini.iteration}}"{{if $curpag==$smarty.section.pagini.iteration}} class="on"{{/if}}>{{$smarty.section.pagini.iteration}}</a>{{/section}}
</div>
<table width="100%" cellpadding="5" cellspacing="1">
<tr bgcolor="#000000" style="color:#FFF">
	<th align="center">#</th>
	<th align="left">Logo</th>
	<th align="left" width="100%">Name</th>
	<th align="center">Manufacturer</th>
	<th align="center">Actions</th>
</tr>
{{foreach $items as $n}}
<tr bgcolor="{{cycle values='#EEE,#CCC'}}">
	<td>{{$n.Id}}</td>
	<td><img src="{{$config.siteurl}}uploads/unit_doors/{{$n.Picture}}" /></td>
	<td><strong>{{$n.Name}}</strong></td>
	<td align="left" nowrap="nowrap">{{foreach $n.Manufacturers as $m}}
    {{$m.Name}}<br />
    {{/foreach}}</td>
    <td align="center"><input type="button" value="Edit" onclick="modifyItem({{$n.Id}})" /><br /><form id="form_{{$n.Id}}" method="post"><input type="hidden" name="action" value="delete" /><input type="hidden" name="Id" value="{{$n.Id}}" /><input type="button" onclick="del({{$n.Id}})" value="Delete" style="margin-top:2px; background:#900" />
</form></td>
</tr>
{{/foreach}}
</table
>
<div class="paginare">
Pages: {{section loop=$pagini name=pagini}} <a href="{{$linkwcp}}&pg={{$smarty.section.pagini.iteration}}"{{if $curpag==$smarty.section.pagini.iteration}} class="on"{{/if}}>{{$smarty.section.pagini.iteration}}</a>{{/section}}
</div>
<script>
$(document).ready(function() {
		$( ".date" ).datepicker({dateFormat:"yy-mm-dd"});
	});
</script>
<script>
function del( obj )
{
	if( confirm('Really delete?') )
	{
		obj = $('#form_'+obj);
		//$(obj).find('input[name=action]').val('delete');
		$(obj).submit();
	}
}
</script>
</div>
<div id="modifyItem0" class="pagePieces" style="display:none">
<h1>Add <input type="button" value="Cancel" onclick="showItemListing()" /></h1>
<fieldset style="margin-bottom:5px">
<legend><strong>Form:</strong></legend>
<form method="post" enctype="multipart/form-data">
<input type="hidden" name="action" value="modify" />
<input type="hidden" name="Id" value="-1" />
<table width="100%" cellpadding="5" cellspacing="1">
<tr>
	<td nowrap="nowrap"><strong>Name:</strong></td>
	<td width="100%"><input type="text" name="Name" value="" /></td>
</tr>
<tr>
    <td nowrap="nowrap"><strong>Picture:</strong></td>
    <td><input type="file" name="Picture" value="" /></td>
</tr>
<tr>
	<td nowrap="nowrap" valign="top"><strong>Manufacturer:</strong></td>
    <td>{{foreach $manufacturers as $n}}
    <div style="float:left; margin:1px; width:150px"><input type="checkbox" name="Manufacturers[]" value="{{$n.Id}}"> {{$n.Name}}</div>
    {{/foreach}}</td>
</tr>
<tr>
	<td align="center" colspan="2"><input type="submit" value="Save" /> <input type="button" value="Cancel" onclick="showItemListing()" /></td>
</tr>
</table>
</form>
</fieldset>
</div>
{{foreach $items as $n}}
<div id="modifyItem{{$n.Id}}" class="pagePieces" style="display:none">
{{*<pre>{{$n|@print_r}}</pre>*}}
<h1>Edit <input type="button" value="Cancel" onclick="showItemListing()" /></h1>
<fieldset style="margin-bottom:5px">
<legend><strong>Form:</strong></legend>
<form method="post" enctype="multipart/form-data">
<input type="hidden" name="action" value="modify" />
<input type="hidden" name="Id" value="{{$n.Id}}" />
<table width="100%" cellpadding="5" cellspacing="1">
<tr>
	<td nowrap="nowrap"><strong>Name:</strong></td>
	<td width="100%"><input type="text" name="Name" value="{{$n.Name}}" /></td>
</tr>
<tr>
    <td nowrap="nowrap"><strong>Picture:</strong></td>
    <td><input type="file" name="Picture" value="" /></td>
</tr>
<tr>
	<td nowrap="nowrap" valign="top"><strong>Manufacturer:</strong></td>
    <td>{{foreach $manufacturers as $m}}
    <div style="float:left; margin:1px; width:150px"><input type="checkbox" name="Manufacturers[]" value="{{$m.Id}}"{{if array_key_exists($m.Id,$n.Manufacturers)}} checked="checked"{{/if}}> {{$m.Name}}</div>
    {{/foreach}}</td>
</tr>
<tr>
	<td align="center" colspan="2"><input type="submit" value="Save" /> <input type="button" value="Cancel" onclick="showItemListing()" /></td>
</tr>
</table>
</form>
</fieldset>
</div>
{{/foreach}}
<script>
function addInnerItem(iId){
	$('#innerItemsHolder'+iId).append('<div class="innerItemsHolderChild">'+$($('#innerItemsHolder'+iId+'>div').get(0)).html()+'</div>');
}
function showItemListing()
{
	$('.pagePieces:visible').slideUp();
	$('#listItems').slideDown();
}
function modifyItem( iId )
{
	$('#listItems').slideUp();
	$('#modifyItem'+iId).slideDown();
}
</script>
{{include file='main_pieces/footer.tpl'}}
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>Formulario Pendientes</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.css">

        <!-- Latest compiled and minified JavaScript -->
        <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/bootstrap-table.min.js"></script>

        <!-- Latest compiled and minified Locales -->
        <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.0/locale/bootstrap-table-zh-CN.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.css"/>

        <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.js"></script>

    </head>
    <body>
        <div class="page-header">
            <h1>Pendientes  </h1>
        </div>
        <div class="container">
            <!-- Example row of columns -->
            <div class="row">
                <div class="col-md-4">
                    <form role="form">
                        <div  id="txtDivId" class="form-group" style="display:none;" >
                            <input type="text" class="disabled form-control" id="txtIdPendiente" readonly="readonly">
                        </div>
                        <div class="form-group">
                            <label for="txtNombre">Nombre</label>
                            <input type="text" class="form-control" id="txtNombre">
                        </div>
                        <div class="custom-controls-stacked">
                            <label class="custom-control custom-radio">
                                <input id="radioStacked1" name="radio-stacked" type="radio" class="custom-control-input">
                                <span class="custom-control-indicator"></span>
                                <span class="custom-control-description">Pendiente</span>
                            </label>
                            <label class="custom-control custom-radio">
                                <input id="radioStacked2" name="radio-stacked" type="radio" class="custom-control-input">
                                <span class="custom-control-indicator"></span>
                                <span class="custom-control-description">Aceptada</span>
                            </label>
                        </div>
                        <div class="form-group">
                            <label for="txtFecha">Fecha Alta</label>
                            <input type="text" class="form-control" id="txtFechaAlta">
                        </div>
                        <div class="container">
                            <!-- Example row of columns -->
                            <div class="row">
                                <button onclick="onAgregar()" type="button" class="btn btn-success" style="display:none;" id="btnAgregar">Agregar</button> <button onclick="onUpdate()" type="button" class="btn btn-warning" style="display:none;" id="btnModificar">Editar</button> <button onclick="onDelete()" type="button" class="btn btn-danger" style="display:none;" id="btnEliminar">Eliminar</button>
                            </div>
                        </div>
                        <div id="alertSucces" class="alert alert-success" role="alert" style="display:none;" >
                            <strong>Agregado!</strong> El registro se agrego correctamente.
                        </div>
                        <div id="alertInfo"class="alert alert-info" style="display:none;">
                            <strong>Info!</strong> Indicates a neutral informative change or action.
                        </div>

                        <div id="alertWarn" class="alert alert-warning" style="display:none;">
                            <strong>Precaución!</strong> El registro ha sido modificado
                        </div>

                        <div id="alertDang"class="alert alert-danger" style="display:none;">
                            <strong>Info!</strong> El registro ha sido eliminado
                        </div>
                        <br><br>

                    </form>
                </div>

                <div class="col-md-8">

                    <table id="jsontable" class="display table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>Nombre</th>
                                <th>Estatus</th>
                                <th>Fecha de Alta.</th>
                            </tr>
                        </thead>
                    </table>
                    <div class="form-group" style="float: right;width: 10%">
                        <label for="txtTotal">Total Pendientes</label>
                        <input type="text" class="form-control" id="txtTotal">
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    /* 
     * To change this license header, choose License Headers in Project Properties.
     * To change this template file, choose Tools | Templates
     * and open the template in the editor.
     */
    $(document).ready(function () {
        var oTable = $('#jsontable').dataTable();
        $.ajax({url: 'http://localhost:8084/Terremoto/pendientes/', dataType: 'json',
            success: function (s) {
                console.log(s);
                oTable.fnClearTable();
                $("#txtTotal").val(s.length);
                for (var i = 0; i < s.length; i++)
                {
                    oTable.fnAddData([s[i].id, s[i].nombre, s[i].estatus, s[i].fechaAlta]);
                }
            },
            error: function (e)
            {
                console.log(e.responseText);
            }
        });
        // Add event listener for opening and closing details
        $('#jsontable tbody').on('click', 'tr ', function () {

            var tr = $(this).children("td");
            //var row = oTable.row(tr);
            $("#txtIdPendiente").val(tr[0].textContent);
            $("#txtNombre").val(tr[1].textContent);
            if (tr[2].textContent === "0") {
                $("#radioStacked1").click();
            } else {
                $("#radioStacked2").click();
            }
            $("#txtFechaAlta").val(tr[3].textContent);
        });
        $('#jsontable tbody').on('click', 'tr td', function () {
            var tr = $(this);
            if (tr[0].className === "sorting_1") {

                $("#btnAgregar").hide();
                $("#txtDivId").show();
                $("#btnEliminar").show();
                $("#btnModificar").show();
            } else {
                $("#txtDivId").hide();
                $("#btnAgregar").show();
                $("#btnModificar").hide();
                $("#btnEliminar").hide();
            }
            console.log(tr);
        });
    });
    function queryParams() {
        return {
            type: 'owner',
            sort: 'updated',
            per_page: 100,
            page: 1
        };
    }

    function onAgregar() {
        if ($("#txtNombre").val() === "") {
            alert("Agregar un valor");
            return;
        } else if ($("#txtFechaAlta").val() === "") {
            alert("Agregar un fecha");
            return;
        }
        var jsonParameter = {"nombre": $("#txtNombre").val(), "estatus": "1", "fechaAlta": $("#txtFechaAlta").val()};
        $.ajax({url: 'http://localhost:8084/Terremoto/pendientes',
            type: "POST",
            dataType: 'json',
            beforeSend: function (xhrObj) {
                xhrObj.setRequestHeader("Content-Type", "application/json");
                xhrObj.setRequestHeader("Accept", "application/json");
            },
            data: JSON.stringify(jsonParameter),
            success: function (s) {
                $('#alertSucces').show();
                setTimeout(function () {
                    $('#alertSucces').hide();
                }, 3000);
                recargar();
                lipiarCampos();
            },
            error: function (e)
            {
                console.log(e.responseText);
            }
        });
    }

    function onDelete() {
        var id = $("#txtIdPendiente").val();
        var jsonParameter = {"id": $("#txtIdPendiente").val()};
        $.ajax({
            url: 'http://localhost:8084/Terremoto/pendientes/' + id + '',
            type: 'DELETE',
            beforeSend: function (xhrObj) {
                xhrObj.setRequestHeader("Content-Type", "application/json");
                xhrObj.setRequestHeader("Accept", "application/json");
            },
            data: JSON.stringify(jsonParameter),
            success: function (result) {
                $('#alertDang').show();
                setTimeout(function () {
                    $('#alertDang').hide();
                }, 3000);
                recargar();
                $("#txtDivId").hide();
                lipiarCampos();
            }
        });
    }

    function onUpdate() {
        var id = $("#txtIdPendiente").val();
        if ($("#txtNombre").val() === "") {
            alert("Agregar un valor");
            return;
        } else if ($("#txtFechaAlta").val() === "") {
            alert("Agregar un fecha");
            return;
        }
        var jsonParameter = {"id": id, "nombre": $("#txtNombre").val(), "estatus": "1", "fechaAlta": $("#txtFechaAlta").val()};
        $.ajax({
            url: 'http://localhost:8084/Terremoto/pendientes/' + id + '',
            type: 'POST',
            beforeSend: function (xhrObj) {
                xhrObj.setRequestHeader("Content-Type", "application/json");
                xhrObj.setRequestHeader("Accept", "application/json");
            },
            data: JSON.stringify(jsonParameter),
            success: function (result) {
                $('#alertWarn').show();
                setTimeout(function () {
                    $('#alertWarn').hide();
                }, 3000);
                recargar();
                $("#txtDivId").hide();
                lipiarCampos();
            }
        });
    }

    function recargar() {
        var oTable = $('#jsontable').dataTable();
        $.ajax({url: 'http://localhost:8084/Terremoto/pendientes/', dataType: 'json',
            success: function (s) {
                console.log(s);
                oTable.fnClearTable();
                $("#txtTotal").val(s.length);
                for (var i = 0; i < s.length; i++)
                {
                    oTable.fnAddData([s[i].id, s[i].nombre, s[i].estatus, s[i].fechaAlta]);
                }
            },
            error: function (e)
            {
                console.log(e.responseText);
            }
        });
    }

    function lipiarCampos() {
        $("#txtDivId").hide();
        $("#btnAgregar").show();
        $("#btnModificar").hide();
        $("#btnEliminar").hide();
        $("#txtIdPendiente").val("");
        $("#txtNombre").val("");
        $("#txtFechaAlta").val("");
    }
</script>
</html>

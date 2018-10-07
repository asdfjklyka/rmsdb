var forrequest = 1;
var befrequnit = '';
var befreqdesc = '';
var befreqqtyunits = '';

var EditableTable = function () {

    return {

        //main function to initiate the module
        init: function () {

            function restoreRow(oTable, nRow) {

                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);

                for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                    oTable.fnUpdate(aData[i], nRow, i, false);
                }

                oTable.fnDraw();

            }

            function editRow(oTable, nRow) {

                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);
                // forrequest = aData[0];
                befreqquan = aData[0]; //quantity
                befrequnit = aData[1]; //unit
                befreqdesc = aData[2]; //description
                befreqprono = aData[3]; //property no
                befreqdate = aData[4]; //date acquired
                befreqamt = aData[5]; //amount

                // jqTds[0].innerHTML = '<input type="text" class="form-control small" value="' + aData[0] + '" style="width:100%; color:black;" disabled >';
                jqTds[0].innerHTML = '<input type="number" class="form-control small" value="' + aData[0] + '" style="width:100%; color:black;">'; //UNIT
                jqTds[1].innerHTML = '<input type="text" class="form-control small" value="' + aData[1] + '" style="width:100%; color:black;" >'; //DESCRIPTION
                jqTds[2].innerHTML = '<input type="text" class="form-control small" value="' + aData[2] + '" style="width:100%; color:black;" >'; //QTY UNITS
                jqTds[3].innerHTML = '<input type="text" class="form-control small" value="' + aData[3] + '" style="width:100%; color:black;">'; //UNIT
                jqTds[4].innerHTML = '<input type="text" class="form-control small" value="' + aData[4] + '" style="width:100%; color:black;" >'; //DESCRIPTION
                
                jqTds[5].innerHTML = "<center><a class='btn btn-success edit' href='javascript:;'><i class='fa fa-save '></i></a> <a class='btn btn-danger cancel' href='javascript:;'><i class='fa fa-ban'></i></a></center>";

            }


            function saveRow(oTable, nRow) {

                var jqInputs = $('input', nRow);

                // oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false); //UNIT
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false); //DESCRIPTION
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false); //QTY UNITS
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false); //UNIT
                oTable.fnUpdate(jqInputs[4].value, nRow, 4, false); //DESCRIPTION
                oTable.fnUpdate(jqInputs[5].value, nRow, 5, false); //QTY UNITS
                oTable.fnUpdate("<center><a class='btn btn-primary  edit' href='javascript:;'><i class='fa fa-edit'></i></a> </center>", nRow, 6, false);
                oTable.fnDraw();
            }

            function saveEdit(oTable, nRow) {

                var jqInputs = $('input', nRow);

                // oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false); //UNIT
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false); //DESCRIPTION
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false); //QTY UNITS
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false); //UNIT
                oTable.fnUpdate(jqInputs[4].value, nRow, 4, false); //DESCRIPTION
                oTable.fnUpdate(jqInputs[5].value, nRow, 5, false); //QTY UNITS
                oTable.fnUpdate("<center><a class='btn btn-primary  edit' href='javascript:;'><i class='fa fa-edit'></i></a> <a class='btn btn-danger delete' href='javascript:;''><i class='fa fa-trash-o'></i> </center>", nRow, 6, false);
                oTable.fnDraw();
            }

            function cancelEditRow(oTable, nRow) {
                var jqInputs = $('input', nRow);
                // oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false); //UNIT
                oTable.fnUpdate(jqInputs[4].value, nRow, 4, false); //DESCRIPTION
                oTable.fnUpdate(jqInputs[5].value, nRow, 5, false); //QTY UNITS
                oTable.fnUpdate('<a class="btn btn-success edit" href="">Edit</a>', nRow, 6, false);
                oTable.fnDraw();
            }

            var oTable = $('#editable-sample').dataTable({
                "aLengthMenu": [
                    [100, 15, 20, -1],
                    [100, 15, 20, "All"] // change per page values here
                ],
                // set the initial value
                "iDisplayLength": 100,
                "sDom": "",

                // BRYAN
                // "sDom": "<'row'<'col-lg-6'l><'col-lg-6'f>r>t<'row'<'col-lg-6'i><'col-lg-6'p>>",

                "sPaginationType": "bootstrap",
                "oLanguage": {
                    "sLengthMenu": "_MENU_",

                    // BRYAN
                    // "sLengthMenu": "_MENU_ records per page",

                    "oPaginate": {
                        "sPrevious": "Prev",
                        "sNext": "Next"
                    }
                },
                "aoColumnDefs": [{
                    'bSortable': false,
                    'aTargets': [0]
                }
                ]
            });

            jQuery('#editable-sample_wrapper .dataTables_filter input').addClass("form-control medium"); // modify table search input
            jQuery('#editable-sample_wrapper .dataTables_length select').addClass("form-control xsmall"); // modify table per page dropdown

            var nEditing = null;

            $('#editable-sample a.delete').live('click', function (e) {

                e.preventDefault();

                var nRow = $(this).parents('tr')[0];
                var getval = $(this).closest('tr').children('td:first').text();                

                // swal({

                //     title: "Are you sure?",
                //     text: "The record will be delete.",
                //     type: "warning",
                //     showCancelButton: true,
                //     confirmButtonColor: '#DD6B55',
                //     confirmButtonText: 'Yes',
                //     cancelButtonText: "No",
                //     closeOnConfirm: false,
                //     closeOnCancel: false
                // },

                // function (isConfirm) {
                //     if (isConfirm) {

                        forrequest = forrequest - 1;

                        // swal("Successfully Deleted!", "The data is successfully deleted!", "success");
                        oTable.fnDeleteRow(nRow);

                //     } else
                //         swal("Cancelled", "The transaction is cancelled", "error");

                // });
            });

            //VALIDATION FOR MODAL UNIT
            $('#txtmodalquan').click(function() {
                document.getElementById('txtmodalquanvalidation').innerHTML = "";
            });

            $('#txtmodalquan').on('input', function() {

                if (!document.getElementById('txtmodalquan').value == "")
                {
                    document.getElementById('txtmodalquanvalidation').innerHTML = "";
                }
                else
                {
                    document.getElementById('txtmodalquanvalidation').innerHTML = "Please fill out this field!";
                }
            });
            $('#txtmodalunit').click(function() {
                document.getElementById('txtmodalunitvalidation').innerHTML = "";
            });

            $('#txtmodalunit').on('input', function() {

                if (!document.getElementById('txtmodalunit').value == "")
                {
                    document.getElementById('txtmodalunitvalidation').innerHTML = "";
                }
                else
                {
                    document.getElementById('txtmodalunitvalidation').innerHTML = "Please fill out this field!";
                }
            });
            //END VALIDATION FOR MODAL UNIT

            //VALIDATION FOR MODAL DESCRIPTION
            $('#txtmodaldesc').click(function() {
                document.getElementById('txtmodaldescvalidation').innerHTML = "";
            });

            $('#txtmodaldesc').on('input', function() {

                if (!document.getElementById('txtmodaldesc').value == "")
                {
                    document.getElementById('txtmodaldescvalidation').innerHTML = "";
                }
                else
                {
                    document.getElementById('txtmodaldescvalidation').innerHTML = "Please fill out this field!";
                }
            });
            //END VALIDATION FOR MODAL DESCRIPTION

            //VALIDATION FOR MODAL QTY
            $('#txtmodalprono').click(function() {
                document.getElementById('txtmodalpronovalidation').innerHTML = "";
            });

            $('#txtmodalprono').on('input', function() {

                if (!document.getElementById('txtmodalprono').value == "")
                {
                    document.getElementById('txtmodalpronovalidation').innerHTML = "";
                }
                else
                {
                    document.getElementById('txtmodalpronovalidation').innerHTML = "Please fill out this field!";
                }
            });
            $('#txtmodaldate').click(function() {
                document.getElementById('txtmodaldatevalidation').innerHTML = "";
            });

            $('#txtmodaldate').on('input', function() {

                if (!document.getElementById('txtmodaldate').value == "")
                {
                    document.getElementById('txtmodaldatevalidation').innerHTML = "";
                }
                else
                {
                    document.getElementById('txtmodaldatevalidation').innerHTML = "Please fill out this field!";
                }
            });
            $('#txtmodalamt').click(function() {
                document.getElementById('txtmodalamtvalidation').innerHTML = "";
            });

            $('#txtmodalamt').on('input', function() {

                if (!document.getElementById('txtmodalamt').value == "")
                {
                    document.getElementById('txtmodalamtvalidation').innerHTML = "";
                }
                else
                {
                    document.getElementById('txtmodalamtvalidation').innerHTML = "Please fill out this field!";
                }
            });
            //END VALIDATION FOR MODAL QTY

            $('#btnmodaladd').live('click', function (e) {

                var txtmodalquan = document.getElementById('txtmodalquan').value;
                var txtmodalunit = document.getElementById('txtmodalunit').value;
                var txtmodaldesc= document.getElementById('txtmodaldesc').value;
                var txtmodalprono = document.getElementById('txtmodalprono').value;
                var txtmodaldate = document.getElementById('txtmodaldate').value;
                var txtmodalamt = document.getElementById('txtmodalamt').value;

                if (txtmodalquan == "") 
                {
                    document.getElementById('txtmodalquan').focus();
                    document.getElementById('txtmodalquanvalidation').innerHTML = "Please fill out this field!";
                }
                else if (document.getElementById('txtmodalunit').value == "") 
                {
                    document.getElementById('txtmodalunit').focus();
                    document.getElementById('txtmodalunitvalidation').innerHTML = "Please fill out this field!";
                }
                else if (txtmodaldesc == "")
                {
                    document.getElementById('txtmodaldesc').focus();
                    document.getElementById('txtmodaldescvalidation').innerHTML = "Please fill out this field!";
                }
                else if (txtmodalprono == "")
                {
                    document.getElementById('txtmodalprono').focus();
                    document.getElementById('txtmodalpronovalidation').innerHTML = "Please fill out this field!";
                }
                else if (txtmodaldate == "")
                {
                    document.getElementById('txtmodaldate').focus();
                    document.getElementById('txtmodaldatevalidation').innerHTML = "Please fill out this field!";
                }
                else if (txtmodalamt == "")
                {
                    document.getElementById('txtmodalamt').focus();
                    document.getElementById('txtmodalamtvalidation').innerHTML = "Please fill out this field!";
                }
                else
                {

                    $('#close').click();

                    var aiNew = oTable.fnAddData([txtmodalquan,txtmodalunit, txtmodaldesc, txtmodalprono,txtmodaldate,txtmodalamt, "<center><a class='btn btn-primary edit' href='javascript:;'><i class='fa fa-edit'></i></a> <a class='btn btn-danger delete' href='javascript:;''><i class='fa fa-trash-o'></i></a> </center>"]);
                    var nRow = oTable.fnGetNodes(aiNew[0]);
                        
                document.getElementById('txtmodalquan').value = "";
                document.getElementById('txtmodalunit').value = "";
                document.getElementById('txtmodaldesc').value = "";
                document.getElementById('txtmodalprono').value = "";
                document.getElementById('txtmodaldate').value = "";
                document.getElementById('txtmodalamt').value = "";
                    forrequest = forrequest + 1;

                }

            });

            $('#editable-sample a.cancel').live('click', function (e) {
                e.preventDefault();
                if ($(this).attr("data-mode") == "new") {
                    var nRow = $(this).parents('tr')[0];
                    oTable.fnDeleteRow(nRow);
                } else {
                    restoreRow(oTable, nEditing);
                    nEditing = null;
                }
            });

            $('#editable-sample a.edit').live('click', function (e) {

                e.preventDefault();

                /* Get the row as a parent of the link that was clicked on */
                var nRow = $(this).parents('tr')[0];

                if (nEditing !== null && nEditing != nRow) 
                {
                    /* Currently editing - but not this row - restore the old before continuing to edit mode */
                    restoreRow(oTable, nEditing);
                    editRow(oTable, nRow);
                    nEditing = nRow;
                }
                else if (nEditing == nRow && this.innerText == "") 
                {
                    var jqInputs = $('input', nRow);

                    if (jqInputs[0].value.length > 0)
                    {
                        saveEdit(oTable, nEditing);
                        nEditing = null;
                    }
                } 
                else 
                {
                    editRow(oTable, nRow);
                    nEditing = nRow;
                }

            });
        }

    };

}();
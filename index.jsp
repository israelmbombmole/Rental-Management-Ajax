<%-- 
    Document   : index
    Created on : Jan 11, 2022, 1:16:42 PM
    Author     : ACER I7
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<link rel="stylesheet" href="//cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="//cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
    </head>
    <body>
    <center><nav class="navbar navbar-light" style="background-color: #e3f2fd;">
            <h2> SUNSHINE Rental Management </h2>
        </nav></center>
        <%-- Form --%>
        <br>
        <div class="row">
            <div class="col-sm-4">
                <div class="container">
                    <form id="frmtenant" name="frmtenant">
                        <div class="form-group">
                            <label>Tenant Name</label>
                            <input type="text" name="tname" id="tname" class="form-control" placeholder=""size="30px" required>
                        </div> 
                        
                        <div class="form-group">
                            <label>Tenant Occupation</label>
                            <input type="text" name="toccupation" id="toccupation" class="form-control" placeholder=""size="30px" required>
                        </div> 
                        
                        <div class="form-group">
                            <label>Tenant Monthly Rent</label>
                            <input type="text" name="rent" id="rent" class="form-control" placeholder=""size="30px" required>
                        </div>
                        <br>
                        <div class="form-group">
                            <button type="button" class="btn btn-info" id="save" onclick="addTenant()">Register</button>
                            <button type="button" class="btn btn-warning" id="reset" onclick="reSet()">Reset</button>       
                        </div> 
                    </form>
                </div>  
            </div>
            
            <%-- Table --%>
             <div class="col-sm-8">
                 <div class="panel-body">
                     <table id="tbl-tenant" class="table table-bordered" cellpadding="0" cellspacing="0" width="100%">
                         <thead>
                         <br>
                             <tr>
                                 <th></th>
                                 <th></th>
                                 <th></th>
                                 <th></th>
                                 <th></th>
                             </tr>
                        </thead>
                     </table>
                  </div>
             </div>
        </div>
             <script src="component/component/jquery/jquery.js" type="text/javascript"></script>
             <script src="component/component/jquery/jquery.min.js" type="text/javascript"></script>
             <script src="component/component/jquery.validate.min.js" type="text/javascript"></script>
             <script src="//cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js" type="text/javascript"></script>
             
             
             
             
             
             <script>
                 
               getall();
               var isNew = true;
               var tid = null;
                 
                 function addTenant()
                 {
                    if($("#frmtenant").valid())
                    {
                        var url="";
                        var data="";
                        var method;
                        
                        if(isNew==true)
                        {
                            url = 'add.jsp';
                            data = $("#frmtenant").serialize();
                            method = 'POST'
                        }
                        else
                        {
                            url = 'update.jsp';
                            data = $("#frmtenant").serialize() + "&tid=" + tid;
                            method = 'POST'
                        }
                        
                        
                        $.ajax({
                            type: method,
                            url: url,
                            dataType: 'JSON',
                            data: data,
                            
                            success:function(data)
                            {
                                getall();
                                
                                $('#tname').val("");
                                $('#toccupation').val("");
                                $('#rent').val("");
                                
                                if(isNew==true)
                                {
                                    alert("Record Added successfully...");
                                }
                                else
                                {
                                   alert("Record Updated successfully..."); 
                                }
                            }
                            
                        });
                        
                    }
                 }
                 
                 function getall()
                 {
                     $('#tbl-tenant').dataTable().fnDestroy();
                     $.ajax({
                          url: "tenant.jsp",
                          type: "GET",
                          dataType: "JSON",
                          
                          success:function(data)
                          {
                            $('#tbl-tenant').dataTable({
                              "aaData": data,
                              "scrollX": true,
                              "aoColumns":
                                         [
                                  {"sTitle": "Tenant Name", "mData": "tname"},
                                  {"sTitle": "Occupation", "mData": "toccupation"},
                                  {"sTitle": "Rent Amount", "mData": "rent"},
                                  
                                  {
                                    "sTitle":
                                   "Edit", 
                                   "mData": "id",
                                   "render":function(mData,type,row,meta)
                                   {
                                       return '<button class="btn btn-success" onclick="get_details('+ mData +')">Edit</button>';
                                   }
                                  },
                               
                                  
                                  {
                                    "sTitle":
                                   "Delete", 
                                   "mData": "id",
                                   "render": function(mData,type,row,meta)
                                   {
                                       return '<button class="btn btn-danger" onclick="get_delete('+ mData +')">Delete</button>';
                                   }
                                  },
                                  
                                ]
                                    
                            }); 
                                
                          }
                            
                     });
                  }
                 
                 
                 
                 
                 
                 function get_details(id)
                 {
                     $.ajax({
                         type:"POST",
                         url: "edit.jsp",
                         data : {"id" : id},
                         
                         success: function(data)
                         {
                             isNew = false
                             var obj = JSON.parse(data);
                             tid = obj[0].id
                             
                             $('#tname').val(obj[0].tname);
                             $('#toccupation').val(obj[0].toccupation);
                             $('#rent').val(obj[0].rent);
                             
                         }
                     });
                 } 
                 
                 
                 
                 function get_delete(id)
                 {
                     $.ajax({
                         type: 'POST',
                         url: 'delete.jsp',
                         dataType: 'JSON',
                         data:{"id": id},
                         
                         success: function(data)
                         {
                              alert("Record Deleted successfully...");
                            getall(); 
                             
                         }
                         
                     });
                 }
                 
                 
                 
                 
             </script>
        
        
        
        
        
        
    </body>
</html>

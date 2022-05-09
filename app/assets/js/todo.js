               

jQuery(document).ready(function () {
    jQuery(document).on("click", '#add', function(){
        var content = $('.contents').val()
        $('#checkbox').prop('checked', true);
        $.ajax({
            type: "post", 
            url: "/todo/create",
            data: {todo:{content: content}},
            success: function(data, textStatus, jqXHR){   
                    $('.list_container').html(
                        data
                    )          
                    $("checkbox").change(function() {
                        $(this).css("text-decoration", "line-through");
                      });       
                }  
            ,
            error: function(jqXHR, textStatus, errorThrown){

            }
          })
    return false;
    })
}) 

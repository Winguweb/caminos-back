
function neighborhoodChange(){
  var auxVal = document.getElementById("name_neighborhood");
  var o = auxVal.options[auxVal.selectedIndex].value == 'asc' ? 'asc' : 'desc';
  
  var colIndex = $(".sortable_name").prevAll().length;
  var tbod = $(".sortable_name").closest("table").find("tbody");
  var rows = tbod.find("tr");
 
  rows.sort(function(a,b){
    var A = $(a).find("td").find("#name").eq(colIndex).text();
    var B = $(b).find("td").find("#name").eq(colIndex).text();

    if (!isNaN(A)) A = Number(A);
    if (!isNaN(B)) B = Number(B);
      
    return o == 'asc' ? A > B : B > A;
  });
  
  $.each(rows, function(index, ele){
      tbod.append(ele);
  });
}
function progressChange(){
  
  var auxVal = document.getElementById("progress");
  var o = auxVal.options[auxVal.selectedIndex].value == 'asc' ? 'asc' : 'desc';
  var colIndex = $(".sortable_progress").prevAll().length;
  var tbod = $(".sortable_progress").closest("table").find("tbody");
  var rows = tbod.find("tr");
   
  rows.sort(function(a,b){
    var A =  parseInt($(a).find("td").eq(colIndex).find("#percent").text()); 
    console.log($(a).find("td").eq(colIndex).find("#percent").text());
    var B =  parseInt($(b).find("td").eq(colIndex).find("#percent").text());
    if (!isNaN(A)) A = Number(A);
    if (!isNaN(B)) B = Number(B);
      
    return o == 'asc' ? A > B : B > A;
  });
  
  $.each(rows, function(index, ele){
      tbod.append(ele);
  });

}

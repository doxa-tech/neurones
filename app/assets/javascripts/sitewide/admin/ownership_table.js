$(document).ready(function() {
  var ownershipTable = $("#ownership_table"),
      newOwnership = ownershipTable.find(".new_ownership"),
      newRelation = ownershipTable.find(".new_relation");

  // line clickable
  ownershipTable.on("click", "tbody tr", function(e) {
    var id = $(this).data("url");
    if (typeof id !== "undefined") {
      newRelation.add(newOwnership).addClass("on");
      newRelation.attr("href", "/admin/parents/new?user_id=" + id);
      newOwnership.attr("href", "/admin/ownerships/new?user_id=" + id);
    }
  });
});

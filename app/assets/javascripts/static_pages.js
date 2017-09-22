function changeNeighborhood($this) {
  var neighborhood = $("option:selected", $this).text().toLowerCase();
  window.location.search = 'neighborhood=' + neighborhood;
}

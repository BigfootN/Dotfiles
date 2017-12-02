const DUCKDUCKGO_SEARCH_URL="https://duckduckgo.com/?q=";

function search(e) {
	if (e.keyCode === 13) {
		e.preventDefault();

		var search_typed = document.getElementById('dduckgo_src').value;
		var complete_url = DUCKDUCKGO_SEARCH_URL.concat(search_typed);

		window.open(complete_url, "_self");
	}
}
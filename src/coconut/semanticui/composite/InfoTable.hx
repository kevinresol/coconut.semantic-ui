package coconut.semanticui.composite;

import tink.pure.List;

using tink.CoreApi;

class InfoTable extends coconut.ui.View<{entries:List<Named<String>>}> {
	function render() '
		<table class="ui unstackable very basic table">
			<for ${entry in entries}>
				<tr>
					<td class="collapsing"><strong>${entry.name}</strong></td>
					<td>${entry.value}</td>
				</tr>
			</for>
		</table>
	';
}
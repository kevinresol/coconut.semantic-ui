package coconut.semanticui.composite;

import tink.pure.List;

using tink.CoreApi;

class InfoTable extends coconut.ui.View {
	@:attribute var entries:List<Value>;
	function render() '
		<table class="ui unstackable very basic table">
			<tbody>
				<for ${entry in entries}>
					<tr>
						<td class="collapsing"><strong>${entry.title}</strong></td>
						<td style=${{whiteSpace:'pre-wrap'}}>
							<if ${entry.href == null}>
								${entry.value}
							<else>
								<a href=${entry.href}>${entry.value}</a>
							</if>
						</td>
					</tr>
				</for>
			</tbody>
		</table>
	';
}

private typedef Value = {
	var title(default, never):String;
	var value(default, never):String;
	@:optional var href(default, never):String;
}
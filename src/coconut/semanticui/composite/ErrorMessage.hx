package coconut.semanticui.composite;

using tink.CoreApi;

class ErrorMessage extends coconut.ui.View {
	@:attr var error:Error;
	@:attr var title:String = null;
	
	function render() '
		<div class="ui error message">
			<div class="content">
				<if ${title != null}>
					<div class="header">$title</div>
				</if>
				<p>
					<i class="warning icon"/>
					${error.message}
					<if ${error.data != null}><input type="hidden" value=${Std.string(error.data)}/></if>
				</p>
			</div>
		</div>
	';
}
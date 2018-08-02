package coconut.semanticui;

import tink.pure.List;
import js.jquery.Helper.*;

using tink.CoreApi;
using tink.state.Promised;

class Dropdown<T:String> extends coconut.ui.View {
	@:attr var className:String = 'ui selection dropdown';
	@:attr var name:String = null;
	@:attr var value:T = null;
	@:attr var defaultText:String = null;
	@:attr var entries:Promised<List<Named<T>>>;
	@:attr var onChange:T->Void = null;
	
	function render() {
		trace('render dropdown ' + value);
		return @hxx'
		<div class=${getClassName()}>
			<input type="hidden" name=${name} value=${value}/>
			<i class="dropdown icon"></i>
			<div class="default text">${defaultText}</div>
			<div class="menu">
				<switch ${entries}>
					<case ${Done(data)}>
						<for ${entry in data}>
							<div class="item" data-value=${entry.value}>${entry.name}</div>
						</for>
					<case ${_}>
				</switch>
			</div>
		</div>
	';
	}
	
	inline function getClassName() {
		return className + switch entries {
			case Loading: ' loading';
			case Failed(_): ' error';
			case Done(_): '';
		}
	}
	
	override function afterInit(e) {
		dropdown(e);
	}
	
	override function afterPatching(e) {
		dropdown(e);
	}
	
	function dropdown(e) {
		J(e).dropdown({
			onChange: function(value, text) if(onChange != null) onChange(value),
		});
		if(value == null) J(e).dropdown('clear');
	}
}
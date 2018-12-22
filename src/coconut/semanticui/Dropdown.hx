package coconut.semanticui;

import tink.pure.List;
import tink.domspec.ClassName;
import js.jquery.Helper.*;

using tink.CoreApi;
using tink.state.Promised;

// TODO: support non-string values. (entries should contain a string ID to be used as data-value attr)
class Dropdown<T:String> extends coconut.ui.View {
	@:attr var className:ClassName = 'ui selection dropdown';
	@:attr var name:String = null;
	@:attr var value:T = null;
	@:attr var defaultText:String = null;
	@:attr var entries:Promised<List<Named<T>>>;
	@:attr var onChange:T->Void = null;
	
	function render() '
		<div ref=${setup} class=${getClassName()}>
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
	
	inline function getClassName() {
		return className.add(switch entries {
			case Loading: 'loading';
			case Failed(_): 'error';
			case Done(_): null;
		});
	}
	
	function setup(e) {
		J(e).dropdown({
			onChange: function(value, text) if(onChange != null) onChange(value),
		});
		if(value == null) J(e).dropdown('clear');
	}
}
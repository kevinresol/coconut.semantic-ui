package coconut.semanticui;

import js.jquery.Helper.*;

private typedef ModalClose = {
	function close():Void;
}

class Modal extends coconut.ui.View {
	
	@:attr var className:String = 'ui modal';
	@:attr var style:String = null;
	@:attr var closable:Bool = true;
	@:attr var onConfirm:ModalClose->Void = null;
	@:attr var onCancel:ModalClose->Void = null;
	@:attr var children:coconut.ui.Children = null;
	
	function render() '
		<div class=${className} style=${style}>
			${...children}
		</div>
	';
	
	public function show() {
		var j = J(toElement());
		
		j.modal({
			onApprove: function() {
				return if(onConfirm != null) {
					onConfirm({close: function() j.modal('hide')});
					false;
				} else true;
			},
			onDeny: function() {
				return if(onCancel != null) {
					onCancel({close: function() j.modal('hide')});
					false;
				} else true;
			},
			onHidden: j.remove,
			closable: closable,
		})
		.modal('show');
	}
}
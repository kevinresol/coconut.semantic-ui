package coconut.semanticui.calendar;

import js.jquery.Helper.*;

using DateTools;

class Calendar extends coconut.ui.View {
	@:attr var type:CalendarType;
	@:attr var onChange:Date->Void = null;
	@:attr var formatDate:Date->String = null;
	
	function render() '
		<div class="ui calendar">
			<div class="ui input left icon">
				<i class="calendar icon"/>
				<input type="text"/>
			</div>
		</div>
	';
	
	
	override function afterInit(e) {
		(cast J(e)).calendar({
			type: 'date',
			parser: {
				date: function (text) return text == '' ? null : untyped __js__('new Date({0})', text),
			},
			formatter: {
				date: function (date:Date) return date == null ? '' : formatDate(date),
			},
			onChange: onChange,
		});
	}
		
}

@:enum abstract CalendarType(String) to String {
	var DateTime = 'datetime';
	var Date = 'date';
	var Time = 'time';
	var Month = 'month';
	var Year = 'year';
}
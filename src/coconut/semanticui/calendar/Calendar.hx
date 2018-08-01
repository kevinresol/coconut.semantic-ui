package coconut.semanticui.calendar;

import js.jquery.Helper.*;

using DateTools;

class Calendar extends coconut.ui.View {
	@:attr var type:CalendarType = Date;
	@:attr var onChange:Date->Void = null;
	@:attr var formatDate:Date->String = function(date:Date) return date.toString();
	@:attr var value:Date = null;
	
	function render() '
		<div class="ui calendar">
			<div class="ui input left icon">
				<div class="ui popup calendar"/>
				<i class="calendar icon"/>
				<input type="text" value=${format(value)}/>
			</div>
		</div>
	';
	
	
	override function afterInit(e) {
		(cast J(e)).calendar({
			type: type,
			parser: {
				date: function (text) return text == '' ? null : untyped __js__('new Date({0})', text),
			},
			formatter: {
				date: format,
			},
			onChange: onChange,
		});
	}
	
	function format(date:Date) {
		return date == null ? '' : formatDate(date);
	}
		
}

@:enum abstract CalendarType(String) to String {
	var DateTime = 'datetime';
	var Date = 'date';
	var Time = 'time';
	var Month = 'month';
	var Year = 'year';
}
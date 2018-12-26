package coconut.semanticui.calendar;

import js.jquery.Helper.*;

using DateTools;

class Calendar extends coconut.ui.View {
	@:attr var type:CalendarType = Date;
	@:attr var inlined:Bool = false;
	@:attr var onChange:Date->Void = null;
	@:attr var formatDate:Date->String = function(date:Date) return date.toString();
	@:attr var value:Date = null;
	
	function render() '
		<div ref=${setup} class="ui calendar">
			<if ${!inlined}>
				<div class="ui input left icon">
					<div class="ui popup calendar"/>
					<i class="calendar icon"/>
					<input type="text" value=${format(value)}/>
				</div>
			</if>
		</div>
	';
	
	
	function setup(e) {
		(cast J(e)).calendar({
			type: type,
			'inline': inlined,
			parser: {
				date: function (text) return text == '' ? null : untyped __js__('new Date({0})', text),
			},
			formatter: {
				date: format,
				cell: function(cell:Array<Dynamic>, date:Date, options) {
					var c:Dynamic = cell[0];
					c.style.cursor = 'pointer';
					
					if(!options.disabled) {
						switch date.getDay() {
							case 0: J(c).addClass('sunday');
							case 1: J(c).addClass('monday');
							case 2: J(c).addClass('tuesday');
							case 3: J(c).addClass('wednesday');
							case 4: J(c).addClass('thursday');
							case 5: J(c).addClass('friday');
							case 6: J(c).addClass('saturday');
						}
					}
					return cell;
				}
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
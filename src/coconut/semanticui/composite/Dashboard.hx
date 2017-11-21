package coconut.semanticui.composite;

import coconut.ui.*;
import coconut.router.RouteData;
import coconut.router.RouteData.*;
import tink.pure.*;
import js.jquery.Helper.*;

@:less('dashboard.less')
class Dashboard extends coconut.ui.View<{
	renderSidebar:{className:String}->RenderResult,
	navbar:RenderResult,
	content:RenderResult,
	footer:RenderResult,
	?rightMenu:RenderResult,
}> {
	function render() '
		<div class="pushable">
			<renderSidebar class="ui sidebar inverted vertical menu"/>
			<div class="pusher">
				<div>
					<div class="full height">
						<div class="toc">
							<renderSidebar class="ui inverted attached vertical menu"/>
						</div>
						<div class="main">
							${navbar}
							${content}
						</div>
					</div>
					${footer}
				</div>
			</div>
		</div>
	';
	
	
	
	override function afterInit(e) {
		setup(e);
	}
	
	override function afterPatching(e) {
		setup(e);
	}
	
	function setup(e) {
		J(e).children('.ui.sidebar').sidebar({
			context: J(e),
			transition: 'overlay',
			mobileTransition: 'overlay',
		})
		.sidebar('attach events', J(e).find('.menu .launch.item'));
	}
}

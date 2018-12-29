package coconut.semanticui.composite;

import coconut.ui.*;
import tink.pure.*;
import js.jquery.Helper.*;

/**
 *  Example:
 *  <Dashboard>
 *  	<sidebar attr><Sidebar app=${app} ${...attr}/></renderSidebar>
 *  	<navbar><NavBar app=${app}/></navbar>
 *  	<content><AppContent app=${app}/></content>
 *  	<footer><Footer/></footer>
 *  </Dashboard>
 */

@:less('dashboard.less')
class Dashboard extends coconut.ui.View {
	@:attribute var sidebar:{className:String}->RenderResult;
	@:attribute var content:Children;
	@:attribute var navbar:Children;
	@:attribute var footer:Children;

	function render() '
		<div class="pushable" ref=${setup}>
			<sidebar class="ui sidebar inverted vertical menu"/>
			<div class="pusher">
				<div>
					<div class="full height">
						<div class="toc">
							<sidebar class="ui inverted attached vertical menu"/>
						</div>
						<div class="main">
							${...navbar}
							${...content}
						</div>
					</div>
					${...footer}
				</div>
			</div>
		</div>
	';
	
	function setup(e) {
		J(e).children('.ui.sidebar').sidebar({
			context: J(e),
			transition: 'overlay',
			mobileTransition: 'overlay',
		})
		.sidebar('attach events', J(e).find('.menu .launch.item'));
	}
}

package coconut.semanticui.composite;

import coconut.ui.*;
import tink.pure.*;
#if react
import react.semanticui.*;
#else
import js.jquery.Helper.*;
#end

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
	@:attr var sidebar:Children;
	@:attr var content:Children;
	@:attr var navbar:{toggleSidebar:Void->Void}->Children;
	@:attr var footer:Children;
	
	@:state var sidebarVisible:Bool = false;

	#if react
	function render() 
		<SidebarPushable>
			<Sidebar
				visible=${sidebarVisible}
				class="inverted vertical menu"
				animation="overlay"
				onHide=${() -> sidebarVisible = false}
			>
				${...sidebar}
			</Sidebar>
			<SidebarPusher>
				<div>
					<div class="full height">
						<div class="toc">
							<Menu class="inverted attached vertical menu">${...sidebar}</Menu>
						</div>
						<div class="main">
							${...navbar({toggleSidebar: toggleSidebar})}
							${...content}
						</div>
					</div>
					${...footer}
				</div>
			</SidebarPusher>
		</SidebarPushable>
	;
	
	function toggleSidebar() {
		sidebarVisible = !sidebarVisible;
	}
	
	#else
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
	#end
}

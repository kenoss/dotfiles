// vim: set sw=4 ts=4 fdm=marker et :
var INFO = //{{{
<plugin name="treestyletab" version="0.0.1"
        href="http://medium-rare.jpn.org/assets/treestyletab.js"
        summary="for TreeStyleTab Addon"
        xmlns="http://vimperator.org/namespaces/liberator">
    <author href="http://medium-rare.jpn.org/">gunzee2</author>
    <license href="http://www.opensource.org/licenses/bsd-license.php">New BSD License</license>
    <project name="Vimperator" minVersion="3.0"/>
    <item>
		<description>Control TreeStyleTab Addon (Uses API)</description>
		<description lang="ja">TreeStyleTabアドオンを操作します(APIを使用)</description>
    </item>
    <item>
      	<tags>:treestyle attach</tags>
        <spec>:treestyle at<oa>tach</oa> tabNumber</spec>
        <description>
        <p>
			カレントタブ(%)を選択したタブの子に移動する<br />
			移動元タブの子タブを同時に移動するかは、アドオンの設定に従う
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle attach!</tags>
        <spec>:treestyle at<oa>tach</oa>! tabNumber</spec>
        <description>
        <p>
        	選択したタブをカレントディレクトリ(%)の子に移動する。<br />
			移動元タブの子タブを同時に移動するかは、アドオンの設定に従う
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle detach</tags>
        <spec>:treestyle de<oa>tach</oa> tabNumber</spec>
        <description>
        <p>
			選択したタブをツリーから切り離す<br />
			引数を指定しなかった場合カレントタブ(%)を切り離す<br />
			切り離したタブはタブバーの最後に移動する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle detachChildren or :treestyle dchildren</tags>
        <spec>:treestyle detachC<oa>hildren</oa> parentTabNumber</spec>
        <description>
        <p>
			選択したタブの子タブを全てツリーから切り離す<br />
			引数を指定しなかった場合カレントタブ(%)の子を切り離す<br />
			切り離したタブは全てタブバーの最後に移動する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle detachAll or :treestyle dall</tags>
        <spec>:treestyle detachA<oa>ll</oa></spec>
        <description>
        <p>
			全てのタブをツリーから切り離す
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle expand</tags>
        <spec>:treestyle ex<oa>pand</oa> tabNumber</spec>
        <description>
        <p>
			ツリーを開閉する（閉じている場合は開き、開いている場合は閉じる）<br />
			引数を指定しなかった場合カレントタブ(%)を選択タブとする。<br />
			選択タブがツリーの子の場合、親ツリーを閉じる
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle expandAll or :treestyle eAll</tags>
        <spec>:treestyle expandA<oa>ll</oa></spec>
        <description>
        <p>
			全ツリーを開閉する<br />
			ひとつでも開いている場合は全て閉じ、全て閉じられている場合は全て開く
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle expandAll! or :treestyle eAll!</tags>
        <spec>:treestyle expandA<oa>ll</oa>!</spec>
        <description>
        <p>
			全ツリーを開閉する<br />
			ひとつでも閉じている場合は全て開き、全て開いている場合は全て閉じる
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle duplicate</tags>
        <spec>:treestyle du<oa>plicate</oa> tabNumber</spec>
        <description>
        <p>
			カレントツリーを選択したタブの前に複製する<br />
			引数を指定しなかった場合、全タブの最後に複製する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle duplicate!</tags>
        <spec>:treestyle du<oa>plicate</oa>! tabNumber</spec>
        <description>
        <p>
			選択したツリーをカレントタブの前に複製する<br />
			引数を指定しなかった場合、全タブの最後に複製する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle move</tags>
        <spec>:treestyle mo<oa>ve</oa> tabNumber</spec>
        <description>
        <p>
		カレントタブをツリーから切り離し、指定したタブのルートタブの前へ移動する<br />
		引数を指定しなかった場合最後に移動する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle move!</tags>
        <spec>:treestyle mo<oa>ve</oa>! tabNumber</spec>
        <description>
        <p>
		カレントタブをツリーから切り離し、指定したタブの前(非ルート)へ移動する<br />
		この時移動したタブの親子関係は維持されるため、移動先によってはツリー構造が崩れるので注意
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle promote</tags>
        <spec>:treestyle pr<oa>omote</oa> tabNumber</spec>
        <description>
        <p>
			選択したタブを昇格する（タブを上の階層に上げる）<br />
			引数を指定しなかった場合カレントタブを昇格する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle demote</tags>
        <spec>:treestyle de<oa>mote</oa> tabNumber</spec>
        <description>
        <p>
			選択したタブを降格する（タブを下の階層に下げる）<br />
			引数を指定しなかった場合カレントタブを降格する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle previous</tags>
        <spec>:treestyle pr<oa>evious</oa></spec>
        <description>
        <p>
			同一階層の前のタブへ移動する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle previous!</tags>
        <spec>:treestyle pr<oa>evious</oa>!</spec>
        <description>
        <p>
			同一階層の前のタブへ移動する。<br />
			タブの一番上で実行した際、一番下へループする
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle next</tags>
        <spec>:treestyle ne<oa>xt</oa></spec>
        <description>
        <p>
			同一階層の次のタブへ移動する
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle next!</tags>
        <spec>:treestyle ne<oa>xt</oa>!</spec>
        <description>
        <p>
			同一階層の次のタブへ移動する。<br />
			タブの一番下で実行した際、一番上へループする
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle enabled</tags>
        <spec>:treestyle en<oa>abled</oa></spec>
        <description>
        <p>
			ツリー表示の有効・無効を切り替える。
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle position</tags>
        <spec>:treestyle po<oa>sition</oa> Position</spec>
        <description>
        <p>
			タブバーの位置を変更する。<br />
			変更可能な位置は下記の通り。
        </p>
		<ul>
			<li>Top</li>
			<li>Right</li>
			<li>Bottom</li>
			<li>Left</li>
		</ul>
        </description>
    </item>
    <item>
      	<tags>:treestyle resizeTab</tags>
        <spec>:treestyle resizeT<oa>ab</oa> Width</spec>
        <description>
        <p>
			タブバーを指定した値にリサイズする<br />
			タブバーを右または左に配置していたときのみ有効<br />
			resizeTab!とした場合、常に展開状態のタブバーの幅を変える(未使用の為詳細不明)
        </p>
        </description>
    </item>
    <item>
      	<tags>:treestyle resizeContent</tags>
        <spec>:treestyle resizeC<oa>ontent</oa> Width</spec>
        <description>
        <p>
			ウィンドウ(タブバー以外)を指定した値にリサイズする<br />
			ウィンドウモード時かつ幅に十分な余裕がある時は、ウィンドウ全体を拡大<br />
			フルスクリーンモードまたは幅に十分な余裕がない時は、タブバーを縮める<br />
			resizeContent!とした場合、ウィンドウサイズをそのままに、タブバーのサイズを変更する(未使用の為詳細不明)
        </p>
        </description>
    </item>
</plugin>;
//}}}
(function () {
  	if(!("TreeStyleTabService" in window)) return;
	function tabCompleter(context, args) {
		context.compare = void 0;
		context.completions = tabs.get().sort(function(a, b) { return(b -a);});
		context.createRow = function(item, highlightGroup) {
			if(item == context.title) {
				return	<div highlight={highlightGroup || "CompItem"} style="white-space: nowrap">
						<li highlight="CompDesc">{ item }</li>
						</div>;
			} else {
				let tab = gBrowser.tabs[parseInt(item.text) - 1];
				if (!tab.image)
					tab.image = DEFAULT_FAVICON;
				let state = " ";
				if (tab === gBrowser.selectedTab)
					state = "%";
//				else if (tab === tabs.alternate)
//					state = "#";
				else if (tab.pinned)
					state = "@";
				let nest = tab.getAttribute("treestyletab-nest");
				let img_style = "vertical-align:bottom; width: 16px; height: 16px; margin-left:" + (16 * parseInt(nest)).toString() + "px;";
				return	<div highlight={highlightGroup || "CompItem"} style="white-space: nowrap">
					<li highlight="CompDesc">
					<span style="display:inline-block; width: 5px; text-align: center;">{ state }</span>
					<span style="display:inline-block; width: 18px; text-align: right; margin-right:5px;">{ item.text }:</span>
					<img style={ img_style } src={ tab.image } />
					<span>{ tab.label }</span>
					</li>
					</div>;
			}
		}
	};

	TreeStyleSubCommands = [
		// ツリーを開閉する（閉じている場合は開き、開いている場合は閉じる）
		// 選択タブがツリーの子の場合、親ツリーを閉じる
		new Command(
			'ex[pand]',	
			'Switch \"Collapse\/Expand\" Tree',
			function(args){
				let select = gBrowser.selectedTab;
				if (!isNaN(args) && args != ""){
					select = gBrowser.tabs[parseInt(args) - 1];
				}
				if (TreeStyleTabService.hasChildTabs(select)) {
					if(TreeStyleTabService.isSubtreeCollapsed(select)) {
						gBrowser.treeStyleTab.collapseExpandSubtree(select, false);
					} else {
						gBrowser.treeStyleTab.collapseExpandSubtree(select, true);
					}
				} else {
					let parenttab = TreeStyleTabService.getParentTab(select);
					if(parenttab) {
						gBrowser.treeStyleTab.collapseExpandSubtree(parenttab, true);
					}
				}
			},
			{
				literal: 0,
				completer: function(context, args) {
					context.title = "Switch \"Collapse\/Expand\" Select Tree";
					tabCompleter(context, args);
				},
			},
			true
		),
		// 全ツリーを開閉する
		// ひとつでも開いている場合は全て閉じ、全て閉じられている場合は全て開く
		// expandAll! とした場合、
		// ひとつでも開いている場合は全て開き、全て開いている場合は全て閉じる
		new Command(
			['expandA[ll]','ea[ll]'],	
			'Switch \"Collapse\/Expand\" All Sub Tree',
			function(args){
				let num = gBrowser.tabs.length;
				let tabs = gBrowser.tabs;
				let expand_flag = true;
				if (args.bang) {
					for(let i = 0; i < num; i++) {
						let tab = tabs[i];
						if(TreeStyleTabService.hasChildTabs(tab)) {
							if(TreeStyleTabService.isSubtreeCollapsed(tab)){
								expand_flag = false;
								break;
							}
						}
					}
				} else {
					expand_flag = false;
					for(let i = 0; i < num; i++) {
						let tab = tabs[i];
						if(TreeStyleTabService.hasChildTabs(tab)) {
							if(!TreeStyleTabService.isSubtreeCollapsed(tab)){
								expand_flag = true;
								break;
							}
						}
					}
				}
				gBrowser.treeStyleTab.collapseExpandAllSubtree(expand_flag);
			},
			{
			},
			true
		),
		// カレントタブを選択したタブの子に移動する（attach!で選択ツリーをカレントタブの子に移動）
		// 移動元タブの子タブを同時に移動するかは、アドオンの設定に従う
		new Command(
			'at[tach]',	
			'Attach Current Tab(%) to Selected Tab',
			function(args){
				let current = gBrowser.selectedTab;
				let tab = gBrowser.tabs[parseInt(args) - 1];
				if(args.bang) {
					gBrowser.treeStyleTab.attachTabTo(tab, current);
				} else {
					gBrowser.treeStyleTab.attachTabTo(current, tab);
				}
			},
			{
				literal: 0,
				completer: function(context, args) {
					if(args.bang)
						context.title = "Attach Select Tab ==> Current Tab(%)";
					else
						context.title = "Attach Current Tab(%) ==> Select Tab";
					tabCompleter(context, args);
				},
			},
			true
				),
		// カレントツリーを選択したタブの前に複製する(duplicate!で選択ツリーをカレントタブの前に複製）
		new Command(
			'du[plicate]',	
			'Duplicate Current Tree to Before Selected Tab',
			function(args){
				let current = gBrowser.selectedTab;
				let select = gBrowser.tabs[parseInt(args) - 1];
				if(args.bang) {
					let tabs = TreeStyleTabService.getDescendantTabs(select);
					tabs.unshift(select);
					gBrowser.treeStyleTab.duplicateTabs(tabs,current);
				} else {
					let tabs = TreeStyleTabService.getDescendantTabs(current);
					tabs.unshift(current);
					if(args == "")
						gBrowser.treeStyleTab.duplicateTabs(tabs);
					else
						gBrowser.treeStyleTab.duplicateTabs(tabs,select);
				}
			},
			{
				literal: 0,
				completer: function(context, args) {
				if(args.bang)
					context.title = "Duplicate Select Tree ==> Before Current Tab(%)";
				else
					context.title = "Duplicate Current Tree(%) ==> Before Select Tab";
				tabCompleter(context, args);
			},
			},
			true
			),
		// 選択したタブを昇格する（タブを上の階層に上げる）
		// 引数を指定しなかった場合カレントタブを昇格する
		new Command(
			'pr[omote]',	
			'Promote Selected Tab',
			function(args){
				if(args == "") {
					TreeStyleTabService.promoteCurrentTab();
				} else {
					let tab = gBrowser.tabs[parseInt(args) - 1];
					TreeStyleTabService.promoteTab(tab);
				}
			},
			{
				literal: 0,
				completer: function(context, args) {
					context.title = "Promote Select Tab";
					tabCompleter(context, args);
				},
			},
			true
			),
		// 選択したタブを降格する（タブを下の階層に下げる）
		// 引数を指定しなかった場合カレントタブを降格する
		new Command(
			'de[mote]',	
			'Demote Selected Tab',
			function(args){
				if(args == "") {
					TreeStyleTabService.demoteCurrentTab();
				} else {
					let tab = gBrowser.tabs[parseInt(args) - 1];
					TreeStyleTabService.demoteTab(tab);
				}
			},
			{
				literal: 0,
				completer: function(context, args) {
					context.title = "Demote Select Tab";
					tabCompleter(context, args);
				},
			},
			true
			),
		// 選択したタブをツリーから切り離す
		// 引数を指定しなかった場合カレントタブを切り離す
		// 切り離したタブはタブバーの最後に移動する
		new Command(
			'de[tach]',	
			'Detach Selected Tab from Tree, and Move Last',
			function(args){
				let tab = gBrowser.tabs[parseInt(args) - 1];
				if(args == "") {
					tab = gBrowser.selectedTab;
				}
				gBrowser.treeStyleTab.partTab(tab);
				let tabs = TreeStyleTabService.getDescendantTabs(tab);
				tabs.unshift(tab);
				gBrowser.treeStyleTab.moveTabs(tabs);
			},
			{
				literal: 0,
				completer: function(context, args) {
					context.title = "Detach Select Tab";
					tabCompleter(context, args);
				},
			},
			true
			),
		// 選択したタブの子タブをツリーから切り離す
		// 引数を指定しなかった場合カレントタブの子タブを切り離す
		// 切り離したタブはタブバーの最後に移動する
		new Command(
			['detachC[hildren]','dc[hildren]'],	
			'Detach Selected Tab\'s All Children from Tree, and Move Last',
			function(args){
				let parenttab = gBrowser.tabs[parseInt(args) - 1];
				if(args == "") {
					parenttab = gBrowser.selectedTab;
				}
				let tabs = TreeStyleTabService.getChildTabs(parenttab);
				gBrowser.treeStyleTab.partAllChildren(parenttab);
				gBrowser.treeStyleTab.moveTabs(tabs);
			},
			{
				literal: 0,
				completer: function(context, args) {
					context.title = "Detach Select Tab\'s Children";
					tabCompleter(context, args);
				},
			},
			true
			),
		// 全てのタブをツリーから切り離す
		new Command(
			['detachA[ll]','da[ll]'],	
			'Detach All Tabs from Tree',
			function(){
				let num = gBrowser.tabs.length;
				let tabs = gBrowser.tabs;
				for (i = 0; i < num; i++) {
					let tab = tabs[i];
					gBrowser.treeStyleTab.partTab(tab);
					gBrowser.treeStyleTab.moveTabs(new Array(tab));
				}
			},
			{
			},
			true
			),
		// カレントタブを指定したタブのルートタブの前へ移動する
		// 引数を指定しなかった場合最後に移動する
		// !をつけた場合指定したタブの前(非ルート)へ移動する
		// この時移動したタブの親子関係は維持されるため、移動先によってはツリー構造が崩れる
		new Command(
			'mo[ve]',	
			'Move Current Tab to Selected Tab\'s Root',
			function(args){
				let current = gBrowser.selectedTab;
				let select = gBrowser.tabs[parseInt(args) - 1];
				let tabs = TreeStyleTabService.getDescendantTabs(current);
				tabs.unshift(current);
				if(args.bang) {
					if(args == "") {
						gBrowser.treeStyleTab.moveTabs(tabs);
					} else {
						gBrowser.treeStyleTab.moveTabs(tabs, select);
					}
				} else {
					gBrowser.treeStyleTab.partTab(current);
					if(args == "") {
						gBrowser.treeStyleTab.moveTabs(tabs);
					} else {
						let root = TreeStyleTabService.getRootTab(select);
						if (root === null) {
							gBrowser.treeStyleTab.moveTabs(tabs, select);
						} else {
							gBrowser.treeStyleTab.moveTabs(tabs, root);
						}
					}
				}
			},
			{
				literal: 0,
				completer: function(context, args) {
					if(args.bang) {
						context.title = "Move Current Tab ==> Before Select Tab";
					} else {
						context.title = "Move Current Tab ==> Before Select Tab\'s Root";
					}
					tabCompleter(context, args);
				},
			},
			true
			),
		// 同一階層の前のタブへ移動する
		// previous!とした場合、一番上から一番下へループする
		new Command(
			'p[revious]',	
			'Move View to Previous Sibling Tab',
			function(args){
				let current = gBrowser.selectedTab;
				let previous = TreeStyleTabService.getPreviousSiblingTab(current);
				if (args.bang && previous === null) {
					let parenttab = TreeStyleTabService.getParentTab(current);	
					if (parenttab !== null) {
						previous = TreeStyleTabService.getLastChildTab(parenttab);
					} else {
						let last = gBrowser.tabs[gBrowser.tabs.length - 1]
						let root = TreeStyleTabService.getRootTab(last);
						if (last !== null)
							previous = root;
						else
							previous = last;
					}
					gBrowser.selectedTab = previous;
				} else {
				if (previous !== null)
					gBrowser.selectedTab = previous;
				}
			},
			{
			},
			true
			),
		// 同一階層の次のタブへ移動する
		// next!とした場合、一番下から一番上へループする
		new Command(
			'n[ext]',	
			'Move View to Next Sibling Tab',
			function(args){
				let current = gBrowser.selectedTab;
				let next = TreeStyleTabService.getNextSiblingTab(current);
				if (args.bang && next === null) {
					let parenttab = TreeStyleTabService.getParentTab(current);	
					if (parenttab !== null)
						next = TreeStyleTabService.getFirstChildTab(parenttab);
					else
						next = gBrowser.tabs[0];
					gBrowser.selectedTab = next;
				} else {
					if (next !== null)
						gBrowser.selectedTab = next;
				}
			},
			{
			},
			true
			),
		// タブバーを指定した値にリサイズする
		// タブバーを右または左に配置していたときのみ有効
		// resizeTab!とした場合、常に展開状態のタブバーの幅を変える(未使用の為詳細不明)
		new Command(
			['resizeT[ab]','rt[ab]'],	
			'Resize Tab Bar Width',
			function(args){
				if (!isNaN(args)) {
					width = parseInt(args);
					if (args.bang) {
						TreeStyleTabService.setTabbarWidth(width, true);
					} else {
						TreeStyleTabService.setTabbarWidth(width, false);
					}
				}
			},
			{
				completer: function(context, args) {
					context.title = ["Select Resize Tabbar Width"];
					context.compare = void 0;
					context.completions = [
						["0","to 0"],
						["100","to 100px"],
						["200","to 200px"],
						["300","to 300px"],
						["384","to 384px"],
						["400","to 400px"],
						["480","to 480px"],
						["500","to 500px"],
						["512","to 512px"],
						["600","to 600px"],
						["640","to 640px"],
						["800","to 800px"],
						["960","to 960px"],
						["1024","to 1024px"],
					]
				},
			},
			true
			),
		// ウィンドウ(タブバー以外)を指定した値にリサイズする
		// ウィンドウモード時かつ幅に十分な余裕がある時は、ウィンドウ全体を拡大
		// フルスクリーンモードまたは幅に十分な余裕がない時は、タブバーを縮める
		// resizeContent!とした場合、ウィンドウサイズをそのままに、タブバーのサイズを変更する(未使用の為詳細不明)
		new Command(
			['resizeC[ontent]','rc[ontent]'],	
			'Resize Content Width',
			function(args){
				if (!isNaN(args)) {
					width = parseInt(args);
					if (args.bang) {
						TreeStyleTabService.setContentWidth(width, true);
					} else {
						TreeStyleTabService.setContentWidth(width, false);
					}
				}
			},
			{
				completer: function(context, args) {
					context.title = ["Select Resize Content Width"];
					context.compare = void 0;
					context.completions = [
						["0","to 0"],
						["384","to 384px"],
						["480","to 480px"],
						["512","to 512px"],
						["640","to 640px"],
						["800","to 800px"],
						["960","to 960px"],
						["1024","to 1024px"],
						["1280","to 1280px"],
						["1408","to 1408px"],
						["1600","to 1600px"],
					]
				},
			},
			true
			),
		// タブバーの位置を変更する
		new Command(
			'po[sition]',	
			'Tab Bar Change Position',
			function(args){
				TreeStyleTabService.position = args;
			},
			{
				completer: function(context, args) {
					context.title = ["Select Tabbar Position"];
					context.compare = void 0;
					context.completions = [
						["top","to Top"],
						["right","to Right"],
						["bottom","to Bottom"],
						["left","to Left"],
					]
				},
			},
			true
			),
		// ツリー表示有効・無効切り替え
		new Command(
			'enabled',	
			'Switch Tree View \"Enabled\/Disabled\"',
			function(){
				TreeStyleTabService.treeViewEnabled = !TreeStyleTabService.treeViewEnabled;
			},
			{
			},
			true
			),
		];
	commands.addUserCommand(
		'treestyle',
		'Control TreeStyleTab',
		function (args) (0 - 0),
		{
			bang: true,
		literal: true,
		subCommands: TreeStyleSubCommands,
		},
		true
		);
})();

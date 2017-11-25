<link rel="stylesheet" href="{$systemurl}modules/servers/legendsock/templates/NeWorld/stylesheets/style.css">
<script src="{$systemurl}modules/servers/legendsock/templates/NeWorld/javascripts/layer/layer.js"></script>
<script src="{$systemurl}modules/servers/legendsock/templates/NeWorld/javascripts/qrcode.js"></script>
<script src="{$systemurl}modules/servers/legendsock/templates/NeWorld/javascripts/common.js"></script>
<script src="{$systemurl}modules/servers/legendsock/templates/NeWorld/javascripts/chart.js"></script>

<style>
    #QRCode_HTML {
        display: none;
    }
    #QRCode {
        padding: 10px;
    }
    .layui-layer-content > p {
         color: #666;
         font-size: 12px;
         margin: 0 0 10px 0;
         text-align: center;
     }
</style>

<script>
    {if $chart|@count neq 0}
    var myChart = {
        type: 'line',
        data: {
            labels: [{foreach $chart['upload'] as $key => $value}{$key},{/foreach}],
            datasets: [{
                label: "{$LS_LANG['chart']['upload']} ( MB )",
                data: [{foreach $chart['upload'] as $value}{(($value) / 1048576)|round:2},{/foreach}],
                fill: true,
                backgroundColor: 'rgba(220,220,220,.3)',
                borderColor: 'rgba(220,220,220,1)',
                pointBackgroundColor: 'rgba(220,220,220,1)',
                pointBorderColor: '#fff',
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: 'rgba(220,220,220,1)'
            }, {
                label: "{$LS_LANG['chart']['download']} ( MB )",
                data: [{foreach $chart['download'] as $value}{(($value) / 1048576)|round:2},{/foreach}],
                fill: true,
                backgroundColor: 'rgba(171, 227, 125, .3)',
                borderColor: 'rgba(171, 227, 125, 1)',
                pointBackgroundColor: 'rgba(171, 227, 125, 1)',
                pointBorderColor: '#fff',
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: 'rgba(171, 227, 125, 1)'
            }]
        }
    };
    {/if}
    window.onload = function() {
        var chart = document.getElementById("myChart").getContext("2d");
        window.myLine = new Chart(chart, myChart);
    };
    $(document).ready(function($) {
        // 声明一个 QRCode，选择 id 为 qrcode 的元素
        var qrcode = new QRCode("QRCode", {
            text: "default",
            width: 280,
            height: 280,
            colorDark : "#000",
            colorLight : "#FFF",
            correctLevel : QRCode.CorrectLevel.L
        });
        // 定义 name 为 qrcode 的元素按下时的事件
        $("[name='qrcode']").on('click',function() {
            qrcode.clear(); // 清空图像
            // QR 的名字
            qrname = $(this).attr('data-qrname');
            // QR 的主体内容
            var qrcontent = $(this).attr('data-qrcode');
            // 判断是 Shadowsocks 还是其他的二维码
            switch (qrname) {
                case 'Shadowsocks':
                    // 如果是 Shadowsocks
                    qrcontent = 'ss://' + window.btoa(qrcontent);
                    break;
                case 'ShadowsocksR':
                    // 如果是 ShadowsocksR
                    qrcontent = 'ssr://' + window.btoa(qrcontent);
                    break;
                default:
                    // 默认什么都不做
                    break;
            }
            // 生成另一个图像
            qrcode.makeCode(qrcontent);
            // 弹出层
            layer.open({
                type: 1,
                title: $(this).attr('title'),
                shade: [0.8, '#000'],
                skin: 'layui-layer-demo',
                closeBtn: 1,
                shift: 2,
                shadeClose: true,
                content: document.getElementById('QRCode_HTML').innerHTML + '<p>{$LS_LANG['qrcode']['0']} ' + qrname + ' {$LS_LANG['qrcode']['tips']['1']}</p>'
            });
        });
        $("[name='guiconfig']").on('click',function() {
            function download(fileName, blob){
                var aLink = document.createElement('a');
                var evt = document.createEvent("MouseEvents");
                evt.initEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                aLink.download = fileName;
                aLink.href = URL.createObjectURL(blob);
                aLink.dispatchEvent(evt);
            }

            function stringToBlob(text) {
                var u8arr = new Uint8Array(text.length);
                for (var i = 0, len = text.length; i < len; ++i) {
                    u8arr[i] = text.charCodeAt(i);
                }
                var blob = new Blob([u8arr]);
                return blob;
            }
            var json_content = $(this).attr('data-guiconfig');
            json_content = window.atob(json_content);
            json_content = json_content.replace(/\r\n|\n/g,"");
            json_content = json_content.replace(/\'/ig,"\"");
            var blob = stringToBlob(JSON.stringify(JSON.parse(json_content),null,2));
            download('gui-config.json', blob);
        });
    });
</script>

<div class="row" id="LS">
    {if $notice|@count neq 0}
        <div class="col-md-12">
            <div class="alert alert-warning alert-dismissible fade in" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                {if $notice|@count eq 1}
                    {$notice[0]|trim}
                {else}
                    <ul style="padding: 0px;">
                        {foreach $notice as $value}
                            <li>{$value|trim}</li>
                        {/foreach}
                    </ul>
                {/if}
            </div>
        </div>
    {/if}
    
    <div class="col-sm-6">
		<h1 class="product-title">{$product}</h1>
		<p class="product-desc">{$LS_LANG['nextduedate']} / {$nextduedate}</p>
    </div>
    
    <div class="col-sm-6 text-right">
        <div class="traffic used">
	        {$LS_LANG['traffic']['used']} {if ($info['u'] + $info['d']) gt 1073741824}{(($info['u'] + $info['d']) / 1073741824)|round:2} GB{else}{(($info['u'] + $info['d']) / 1048576)|round:2} MB{/if}
	    </div>
        <div class="traffic free">
	        {$LS_LANG['traffic']['free']} {if (($info['transfer_enable'] - ($info['u'] + $info['d']))) gt 1073741824}{(($info['transfer_enable'] - ($info['u'] + $info['d'])) / 1073741824)|round:2} GB{else}{(($info['transfer_enable'] - ($info['u'] + $info['d'])) / 1048576)|round:2} MB{/if}
	    </div>
    </div>
    
    <div class="col-sm-12">
    	<div class="line"></div>
    </div>
    
    <div class="row">
    	<div class="col-md-4 col-sm-6">
        	<div class="box">
	        	<a menuitemname="{$LANG.clientareanavchangepw}" href="clientarea.php?action=productdetails&id={$serviceid}#tabChangepw" class="btn btn-xs btn-warning pull-right" data-toggle="tab" id="Primary_Sidebar-Service_Details_Actions-Change_Password">
		        	<i class="fa fa-cog" aria-hidden="true"></i>
		        	{$LANG.clientareanavchangepw}
	        	</a>
	        	<h3>{$LS_LANG['product']['title']}</h3>
                <ul>
                	<li><strong>{$LS_LANG['product']['id']}</strong>{$serviceid}</li>
                	<li><strong>{$LS_LANG['product']['port']}</strong>{$info['port']}</li>
                	<li><strong>{$LS_LANG['product']['password']}</strong><code id="password" onclick="javascript:document.getElementById('password').innerHTML='{$password}';">{$LS_LANG['product']['showPassword']}</code></li>
                	<li><strong>{$LS_LANG['product']['lastTime']}</strong>{$info['t']|date_format:'%Y-%m-%d %H:%M'}</li>
                </ul>
        	</div>
    	</div>
    	<div class="col-md-4 col-sm-6">
        	<div class="box">
	        	<h3>{$LS_LANG['plugin']['title']}</h3>
                <ul>
                	<li><strong>{$LS_LANG['plugin']['method']}</strong>{$info['method']}</li>
                	<li><strong>{$LS_LANG['plugin']['protocol']}</strong>{$info['protocol']}</li>
                	<li><strong>{$LS_LANG['plugin']['obfs']}</strong>{$info['obfs']}</li>
                	<li><strong>{$LS_LANG['plugin']['guiconfig']}</strong>
                                <div class="btn-group btn-group-xs" role="group" aria-label="Extra-small button group">
                                    <button type="button" class="btn btn-success btn-xs autoset" name="guiconfig" data-guiconfig="{$guiconfig['ss']}">
                                        <span class="glyphicon glyphicon-send" aria-hidden="true"></span> {$LS_LANG['plugin']['general']}
                                    </button>
                                    <button type="button" class="btn btn-primary btn-xs autohides" name="guiconfig" data-guiconfig="{$guiconfig['ssr']}">
                                        <span class="glyphicon glyphicon-export" aria-hidden="true"></span> {$LS_LANG['plugin']['ssr']}
                                    </button>
                                </div></li>
                </ul>
        	</div>
    	</div>
    	<div class="col-md-12 col-sm-12">
        	<h3>{$LS_LANG['node']['title']} <small>{$LS_LANG['node']['head']['0']} {$node|@count} {$LS_LANG['node']['head']['1']}</small></h3>
            <div class="row node-list">
            {if $node|@count neq 0}
                {foreach $node as $value}
                    {$value=("|"|explode:$value)}
                    <div class="col-md-4 col-sm-6">
                    	<div class="box">
                            <h4>{$value[0]|trim} <span class="status status-success"></span></h4>
                            <div class="row">
	                            <div class="col-sm-8" style="padding-right: 0;">
		                            <div class="main">
		                            	<code>{$value[1]|trim}</code>
										<p>{$value[2]|trim}</p>
		                            </div>
	                            </div>
	                            <div class="col-sm-4" style="padding-left: 0;">
		                            <div class="qcode">
		                                
		                                <button type="button" class="btn btn-success btn-xs btn-block" data-qrname="Shadowsocks" data-qrcode="{$info['method']}:{$password}@{$value[1]|trim}:{$info['port']}" title="{$LS_LANG['node']['general']['title']}" name="qrcode">
		                                    <span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span> {$LS_LANG['node']['general']['name']}
		                                </button>
		                                
		                                <button type="button" class="btn btn-primary btn-xs btn-block" data-qrname="ShadowsocksR" data-qrcode="{$value[1]|trim}:{$info['port']}:{$info['protocol']}:{$info['method']}:{$info['obfs']}:{$password|base64_encode}" title="{$LS_LANG['node']['ssr']['title']}" name="qrcode">
		                                    <span class="glyphicon glyphicon-qrcode" aria-hidden="true"></span> {$LS_LANG['node']['ssr']['name']}
		                                </button>
		                                    
		                            </div>
	                            </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            {/if}
            </div>
        </div>
    </div>
    
    <div class="col-sm-12 hidden-xs">
    	<div class="line"></div>
    </div>
    
    <div class="row hidden-xs">
        {if $chart|@count neq 0}
            <div class="col-md-12">
                <div class="alert alert-info" role="alert" style="text-align: center; font-size: 12px">
                    {$LS_LANG['chart']['tips']}
                </div>
            </div>
        {/if}
    	<div class="col-md-12">
            {if $addition}
                <div class="alert alert-info alert-dismissible fade in" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                    <h4 style="margin-top: 0; font-weight: bold;"><span class="glyphicon glyphicon-heart" aria-hidden="true"></span> {$LS_LANG['traffic']['title']}</h4>
                    <p style="font-size: 15px;">{$LS_LANG['traffic']['tips']['0']}</p>
                    <p style="font-size: 12px;">{$LS_LANG['traffic']['tips']['1']} <span style="font-weight: bold; color: red;">{$serviceid}</span> {$LS_LANG['traffic']['tips']['2']}</p>
                    <p style="margin-top: 10px;">
                        <button type="button" class="btn btn-default" onclick="javascript:if (confirm('{$LS_LANG['traffic']['confirm']}')) window.location.href='{$systemurl}cart.php?a=add&pid=2';">{$LS_LANG['traffic']['order']}</button>
                    </p>
                </div>
            {/if}
            {if $chart|@count neq 0}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <span class="badge" title="{$LS_LANG['chart']['date']}">{$chart['date']|date_format:'%Y-%m-%d'}</span>
                        <h4 class="panel-title">{$LS_LANG['chart']['title']}</h4>
                    </div>
                    <div class="panel-body">
                        <canvas id="myChart"></canvas>
                    </div>
                </div>
            {/if}
            {if $resource|@count neq 0}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">{$LS_LANG['resource']}</h4>
                    </div>
                    <div class="list-group">
                        {foreach $resource as $value}
                            {$value=("|"|explode:$value)}
                            <a href="{$value[1]|trim}" class="list-group-item">
                                <h4 class="list-group-item-heading">{$value[0]|trim}</h4>
                                <p class="list-group-item-text">{$value[2]|trim}</p>
                            </a>
                        {/foreach}
                    </div>
                </div>
            {/if}
        </div>
    </div>
</div>

<div id="QRCode_HTML">
    <div id="QRCode" style="width: 300px;height: 300px;"></div>
</div>
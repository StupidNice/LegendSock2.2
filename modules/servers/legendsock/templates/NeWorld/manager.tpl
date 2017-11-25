<link rel="stylesheet" href="{$systemurl}modules/servers/legendsock/templates/LegendSock/stylesheets/style.css">
{*<script src="{$systemurl}modules/servers/legendsock/templates/LegendSock/javascripts/layer/layer.js"></script>*}
<script src="{$systemurl}modules/servers/legendsock/templates/LegendSock/javascripts/common.js"></script>

<style type="text/css">
    h1 {
        display: none;
    }
</style>

<div class="row" id="LS">
    <div class="col-md-12">
        {if $tips eq 'success'}
            {include file="{$template}tips/success.tpl"}
        {elseif $tips eq 'danger'}
            {include file="{$template}tips/danger.tpl"}
        {else}
            {include file="{$template}tips/warning.tpl"}
        {/if}
        {$information}
    </div>
    <div class="col-md-3">
        <div class="box-sm">
            <div class="box-sm-top">
                注册站点
            </div>
            <div class="box-sm-content">
                <span class="box-sm-font">{$verifySite}</span> <span class="box-sm-font-sm">&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;{$verifySiteType}</span>
            </div>
            <div class="box-sm-bottom">
                {if $notice|@count eq 1}
                    {$notice[0]|trim}
                {else}
                    <ul class="alert" style="padding: 0; margin: 0;">
                        {foreach $notice as $value}
                            <li>{$value|trim}</li>
                        {/foreach}
                    </ul>
                {/if}
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="box-sm">
            <div class="box-sm-top">
                模块版本
            </div>
            <div class="box-sm-content">
                <span class="box-sm-font">终身授权</span> <span class="box-sm-font-sm">&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;v{$version} 正式版</span>
            </div>
            <div class="box-sm-bottom">
                {if $update > $version}检测到新版(v{$update}), 请前往注册站点下载{else}当前的模块版本为最新版{/if}
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="box-sm">
            <div class="box-sm-top">
                截止今日
            </div>
            <div class="box-sm-content">
                <span class="box-sm-font">产品数量</span> <span class="box-sm-font-sm">&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;{$productCount} 个 <span class="glyphicon glyphicon-arrow-{if $productCount gt $productCountOld}up{elseif $productCount lt $productCountOld}down{else}right{/if}"></span></span>
            </div>
            <div class="box-sm-bottom">
                昨日有 {$productCountOld} 个产品，今日{if $productCount gt $productCountOld}有提升{elseif $productCount lt $productCountOld}有下降{else}无变化{/if}
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="box-sm">
            <div class="box-sm-top">
                所有节点
            </div>
            <div class="box-sm-content">
                <span class="box-sm-font">流量消耗</span> <span class="box-sm-font-sm">&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;{($trafficCount / 1073741824)|round:2} GB <span class="glyphicon glyphicon-arrow-{if $trafficCount gt $trafficCountOld}up{elseif $trafficCount lt $trafficCountOld}down{else}right{/if}"></span></span>
            </div>
            <div class="box-sm-bottom">
                昨日 {($trafficCountOld / 1073741824)|round:2} GB，今日{if $trafficCount gt $trafficCountOld}有提升{elseif $trafficCount lt $trafficCountOld}有下降{else}无变化{/if}
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <ul class="nav nav-tabs" role="tablist" style="margin-bottom: 18px;">
            <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">首页</a></li>
            {if $page['name'] eq 'home'}
                <li role="presentation"><a href="#other" aria-controls="other" role="tab" data-toggle="tab">其他</a></li>
            {/if}
            <li style="float: right; padding: 5px 0px;">
                <form action="{$modulelink}" method="post" id="converter">
                    <input name="action" value="converter" type="hidden">
                </form>
                {if $page['name'] eq 'home'}
                    <button type="button" class="btn btn-default btn-xs" onclick="javascript:document.getElementById('converter').submit();">
                        <span class="glyphicon glyphicon-transfer" aria-hidden="true"></span> 数据转换
                    </button>
                {else}
                    <button type="button" class="btn btn-default btn-xs" onclick="javascript:if (confirm('将跳转至 LegendSock 控制面板首页')) window.location.href='addonmodules.php?module=legendsock';">
                        <span class="glyphicon glyphicon-home" aria-hidden="true"></span> 回到首页
                    </button>
                {/if}
            </li>
        </ul>
    </div>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="home">
            <div class="col-md-12">
                {if $page['name'] eq 'converter'}
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <span class="badge">共找到 {$converter['rows']} 个数据库</span>
                            <h3 class="panel-title">数据库转换</h3>
                        </div>
                        <div class="legend-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>数据库名称</th>
                                    <th>数据库用户</th>
                                    <th>数据库密码</th>
                                    <th>数据库主机</th>
                                    <th>数据库端口</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $converter['info'] as $key => $value}
                                    <tr>
                                        <td>{$key}</td>
                                        <td>{$value['database']}</td>
                                        <td>{$value['username']}</td>
                                        <td>{$value['password']}</td>
                                        <td>{$value['hostname']}</td>
                                        <td>{$value['port']}</td>
                                        <td>
                                            <form action="{$modulelink}" method="post" style="margin: 0;" id="converter_{$key}">
                                                <input name="action" value="submit_converter" type="hidden">
                                                <input name="id" value="{$key}" type="hidden">
                                            </form>
                                            <button type="button" class="btn btn-danger btn-xs" onclick="javascript:if(confirm('请确认数据库已提前备份')) if (confirm('你真的确定要这么做吗？')) document.getElementById('converter_{$key}').submit();">
                                                <span class="glyphicon glyphicon-floppy-open" aria-hidden="true"></span> 开始转换
                                            </button>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                {elseif $page['name'] eq 'product'}
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <span class="badge">共找到 {$product['rows']} 个产品</span>
                            <h3 class="panel-title">产品管理</h3>
                        </div>
                        <div class="legend-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>用户 ID</th>
                                    <th>产品 ID</th>
                                    <th>端口编号</th>
                                    <th>产品状态</th>
                                    <th>套餐流量</th>
                                    <th>剩余流量</th>
                                    <th>最近连接</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $product['result'] as $value}
                                    <tr>
                                        {if $value['uid'] eq 'unknown'}
                                            <td>{$value['uid']}</td>
                                            <td>{$value['pid']}</td>
                                        {else}
                                            <td onclick="javascript:if (confirm('将跳转至账户页面')) window.location.href='clientsprofile.php?userid={$value['uid']}';">
                                                {$value['uid']}
                                            </td>
                                            <td onclick="javascript:if (confirm('将跳转至产品页面')) window.location.href='clientsservices.php?userid={$value['uid']}&id={$value['pid']}';">
                                                {$value['pid']}
                                            </td>
                                        {/if}
                                        <td>{$value['port']}</td>
                                        <td>{$value['status']}</td>
                                        <td>{($value['transfer_enable'] / 1048576)|round:2} MB {if $value['addition']}<span style="color: #CCC;">( 包含叠加 {($value['addition'] / 1048576)|round:2} MB )</span>{/if}</td>
                                        <td>{(($value['transfer_enable'] - ($value['u'] + $value['d'])) / 1048576)|round:2} MB</td>
                                        <td>{$value['t']|date_format:'%Y-%m-%d, %H:%M'}</td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                        {if $previous eq true || $next eq true}
                            <div class="panel-body" style="border-top: 1px solid #EAEAEA;">
                                <nav>
                                    <ul class="pager" style="margin: 0;">
                                        {if $previous eq true}
                                            <li class="previous">
                                                <form action="{$modulelink}" method="post" id="previous">
                                                    <input name="action" value="product" type="hidden">
                                                    <input name="direction" value="previous" type="hidden">
                                                    <input name="id" value="{$product['id']}" type="hidden">
                                                    <input name="page" value="{$page['number']}" type="hidden">
                                                </form>
                                                <a href="javascript:document.getElementById('previous').submit();"><span aria-hidden="true">←</span> 上一页</a>
                                            </li>
                                        {/if}
                                        {if $next eq true}
                                            <li class="next">
                                                <form action="{$modulelink}" method="post" id="next">
                                                    <input name="action" value="product" type="hidden">
                                                    <input name="direction" value="next" type="hidden">
                                                    <input name="id" value="{$product['id']}" type="hidden">
                                                    <input name="page" value="{$page['number']}" type="hidden">
                                                </form>
                                                <a href="javascript:document.getElementById('next').submit();">下一页 <span aria-hidden="true">→</span></a>
                                            </li>
                                        {/if}
                                    </ul>
                                </nav>
                            </div>
                        {/if}
                    </div>
                {elseif $page['name'] eq 'notice'}
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <h3 class="panel-title">编辑通知</h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <p>
                                    格式: <code>第一条通知 | 第二条通知 | 第 N 条通知</code>
                                </p>
                                <form action="{$module}" method="post" id="notice">
                                    <input type="hidden" name="action" value="edit_notice">
                                    <input type="hidden" name="id" value="{$id}">
                                    <div class="form-group">
                                        <textarea class="form-control" rows="10" name="notice">{$notice}</textarea>
                                    </div>
                                </form>
                            </div>
                            <button onclick="javascript:if(confirm('这将会覆盖原来数据库中的通知信息')) document.getElementById('notice').submit();" class="btn btn-warning"><span class="glyphicon glyphicon-open" aria-hidden="true"></span> 提交修改</button>
                        </div>
                    </div>
                {elseif $page['name'] eq 'node'}
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title">编辑节点</h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <p>
                                    格式: <code>节点名称 | 连接地址 | 备注信息</code>
                                </p>
                                <form action="{$module}" method="post" id="node">
                                    <input type="hidden" name="action" value="edit_node">
                                    <input type="hidden" name="id" value="{$id}">
                                    <div class="form-group">
                                        <textarea class="form-control" rows="10" name="node">{$node}</textarea>
                                    </div>
                                </form>
                            </div>
                            <button onclick="javascript:if(confirm('这将会覆盖原来数据库中的节点信息')) document.getElementById('node').submit();" class="btn btn-info"><span class="glyphicon glyphicon-open" aria-hidden="true"></span> 提交修改</button>
                        </div>
                    </div>
                {elseif $page['name'] eq 'resource'}
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <h3 class="panel-title">编辑资源</h3>
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <p>
                                    格式: <code>资源名称 | 资源地址 | 资源描述</code>
                                </p>
                                <form action="{$module}" method="post" id="resource">
                                    <input type="hidden" name="action" value="edit_resource">
                                    <input type="hidden" name="id" value="{$id}">
                                    <div class="form-group">
                                        <textarea class="form-control" rows="10" name="resource">{$resource}</textarea>
                                    </div>
                                </form>
                            </div>
                            <button onclick="javascript:if(confirm('这将会覆盖原来数据库中的资源信息')) document.getElementById('resource').submit();" class="btn btn-success"><span class="glyphicon glyphicon-open" aria-hidden="true"></span> 提交修改</button>
                        </div>
                    </div>
                {else}
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            <span class="badge">共找到 {$database['rows']} 个数据库</span>
                            <h3 class="panel-title">数据库管理</h3>
                        </div>
                        <div class="legend-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>数据库名称</th>
                                    <th>数据库主机</th>
                                    <th>部署状态</th>
                                    <th>产品数量</th>
                                    <th>通知信息</th>
                                    <th>节点信息</th>
                                    <th>资源信息</th>
                                    <th>初始化</th>
                                    <th>格式化</th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $database['info'] as $key => $value}
                                    <tr>
                                        <td>{$key}</td>
                                        <td>{$value['database']}</td>
                                        <td>{$value['hostname']}</td>
                                        <td><span class="glyphicon glyphicon-{if $value['status']}ok{else}remove{/if}"></span></td>
                                        <td>
                                            {if $value['count']}
                                                <form action="{$modulelink}" method="post" style="margin: 0;">
                                                    <input name="action" value="product" type="hidden">
                                                    <input name="id" value="{$key}" type="hidden">
                                                    <button type="submit" class="btn btn-default btn-xs"{if !$value['status']} disabled="disabled"{/if}>
                                                        {$value['count']}
                                                    </button>
                                                </form>
                                            {else}
                                                0
                                            {/if}
                                        </td>
                                        <td>
                                            <form action="{$modulelink}" method="post" style="margin: 0;">
                                                <input name="action" value="notice" type="hidden">
                                                <input name="id" value="{$key}" type="hidden">
                                                <button type="submit" class="btn btn-warning btn-xs"{if !$value['status']} disabled="disabled"{/if}>
                                                    <span class="glyphicon glyphicon-bullhorn" aria-hidden="true"></span> 编辑通知
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <form action="{$modulelink}" method="post" style="margin: 0;">
                                                <input name="action" value="node" type="hidden">
                                                <input name="id" value="{$key}" type="hidden">
                                                <button type="submit" class="btn btn-info btn-xs"{if !$value['status']} disabled="disabled"{/if}>
                                                    <span class="glyphicon glyphicon-tasks" aria-hidden="true"></span> 编辑节点
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <form action="{$modulelink}" method="post" style="margin: 0;">
                                                <input name="action" value="resource" type="hidden">
                                                <input name="id" value="{$key}" type="hidden">
                                                <button type="submit" class="btn btn-success btn-xs"{if !$value['status']} disabled="disabled"{/if}>
                                                    <span class="glyphicon glyphicon-th-list" aria-hidden="true"></span> 编辑资源
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <form action="{$modulelink}" method="post" style="margin: 0;">
                                                <input name="action" value="init" type="hidden">
                                                <input name="id" value="{$key}" type="hidden">
                                                <button type="submit" class="btn btn-primary btn-xs">
                                                    <span class="glyphicon glyphicon-floppy-open" aria-hidden="true"></span> 初始化表
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <form action="{$modulelink}" method="post" style="margin: 0;" id="format_{$key}">
                                                <input name="action" value="format" type="hidden">
                                                <input name="id" value="{$key}" type="hidden">
                                            </form>
                                            <button type="button" class="btn btn-danger btn-xs" onclick="javascript:if(confirm('这将会清空数据库中的所有内容，你确认要这么做吗？')) if (confirm('你真的确定要这么做吗？')) document.getElementById('format_{$key}').submit();"{if !$value['status']} disabled="disabled"{/if}>
                                                <span class="glyphicon glyphicon-floppy-remove" aria-hidden="true"></span> 格式化表
                                            </button>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
        {if $page['name'] eq 'home'}
            <div role="tabpanel" class="tab-pane" id="other">
                <div class="col-md-12">
                    <div class="alert alert-warning alert-dismissible fade in" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                        <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> <strong>部署须知！</strong> 需要完整实现模块的各项功能、必须使用 LegendSock Server 作为服务器后端，不支持其他的任何原版或各种修改版后端
                    </div>
                    {if $errorHost}
                        <div class="alert alert-danger alert-dismissible fade in" role="alert">
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                            <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> <strong>出现错误！</strong> 系统检测到你有数据库连接地址填写 127.0.0.1 或 localhost，这将会影响全自动安装功能在安装时替换正确的数据库地址
                        </div>
                    {/if}
                </div>
                <div class="col-md-3">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title">扩展功能</h3>
                                </div>
                                <div class="panel-body" style="color: #666;">
                                    <p><strong>模板切换</strong></p>
                                    <p>支持以 Smarty 规范编写的模板，放置于如下目录:</p>
                                    <pre>{$root}modules/servers/legendsock/templates</pre>
                                    <p>若模板放置位置正确、则可以在填写授权编号的地方自动显示</p>
                                    <p><strong>语言输出</strong></p>
                                    <p>支持以数组方式编写语言包，语言包放置于如下目录:</p>
                                    <pre>{$root}modules/servers/legendsock/languages</pre>
                                    <p style="margin-bottom: 0">若放置正确、系统即可跟随客户设置的 WHMCS 语言自动切换</p>
                                </div>
                            </div>
                            <div class="panel panel-success">
                                <div class="panel-heading">
                                    <h3 class="panel-title">后端程序</h3>
                                </div>
                                <div class="panel-body" style="color: #666;">
                                    <p><strong>脚本说明</strong></p>
                                    <p>基于 ShadowsocksR Manyuser 修改的版本，支持自定义加密方式与混淆、协议插件，与其他 SS 销售模块或程序不兼容</p>
                                    <p><strong>安装方式</strong></p>
                                    <p>提供有基于 CentOS 6.x 64bit 所编写的 Shell Script 可提供手动输入数据库信息后自动安装，同时也有提供自动生成相应数据库信息的 Shell Script 全自动安装与完全手动安装等三种安装方式，详情请查阅本页面的其他板块</p>
                                    <p><strong>其他说明</strong></p>
                                    <p style="margin-bottom: 0">这还是一个开源项目，可查阅: <a href="https://github.com/babytomas/LegendSock-Server" target="_blank">Github</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h3 class="panel-title">全自动安装</h3>
                                </div>
                                <div class="panel-body" style="color: #666;">
                                    <p><strong>安装说明</strong></p>
                                    {if $script eq 'test'}
                                        <p style="margin-bottom: 0">在进行操作之前，请先修改 {$root}modules/addons/legendsock 下的 config.php 文件，将 <code>'script' => 'test'</code> 中的 test 当做密码一样改为复杂或随机的字符串</p>
                                    {else}
                                        <p>使用此方法可无需手动输入数据库信息，实现全自动安装，仅支持 CentOS 6</p>
                                        <p>为确保不会被恶意利用，请将 config.php 文件中 <code>'script' => '{$script}'</code> 修改的尽可能复杂、避免泄露数据库连接信息</p>
                                        <p><strong>安装方式</strong></p>
                                        <p>在 Terminal 中执行如下命令:</p>
                                        <pre>wget -O /tmp/install.sh {$systemurl}/modules/addons/legendsock/install.php?{$script}=xxx;
chmod +x /tmp/install.sh;
/tmp/install.sh;</pre>
                                        <p>如上的 <code>xxx</code> 修改为你在 LegendSock 控制面板首页看到的数据库 ID 编号，执行后按照提示按下任意键完成安装即可</p>
                                        <p><strong>卸载方式</strong></p>
                                        <p style="margin-bottom: 0">详情请查阅 Github 文字教程: <a href="https://github.com/babytomas/LegendSock-Server" target="_blank">https://github.com/babytomas/LegendSock-Server</a></p>
                                    {/if}
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h3 class="panel-title">半自动安装</h3>
                                </div>
                                <div class="panel-body" style="color: #666;">
                                    <p><strong>安装说明</strong></p>
                                    <p>使用此方法需要手动输入数据库信息后方可自动安装，仅支持 CentOS 6</p>
                                    <p><strong>安装方式</strong></p>
                                    <p style="margin-bottom: 0">详情请查阅 Github 文字教程: <a href="https://github.com/babytomas/LegendSock-Server" target="_blank">https://github.com/babytomas/LegendSock-Server</a></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    <h3 class="panel-title">全手动安装</h3>
                                </div>
                                <div class="panel-body" style="color: #666;">
                                    <p><strong>安装说明</strong></p>
                                    <p style="margin-bottom: 0">使用此方法与 ShadowsocksR 安装方式相同，详情可查阅: <a href="https://github.com/breakwa11/shadowsocks-rss/wiki/Server-Setup(manyuser-with-mysql)" target="_blank">https://github.com/breakwa11/shadowsocks-rss/wiki/Server-Setup(manyuser-with-mysql)</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
    <div class="col-md-12">
        <p style="text-align: center; color: #CCC; font-size: 12px;">Powered by Hostribe, Version: {$version}</p>
    </div>
</div>
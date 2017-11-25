<link rel="stylesheet" href="{$systemurl}modules/servers/legendsock/templates/LegendSock/stylesheets/style.css">

<div id="LS">
    <div class="legend-responsive" style="margin: -5px; padding: 5px 0; background-color: white;">
        <table class="table" style="border: 1px solid #EAEAEA;">
            <thead>
            <tr>
                <th>端口编号</th>
                <th>上传流量</th>
                <th>下载流量</th>
                <th>叠加流量</th>
                <th>剩余流量</th>
                <th>加密方式</th>
                <th>协议插件</th>
                <th>混淆插件</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td style="width: 10%" id="LS_Port">
                    <span onclick="javascript:document.getElementById('LS_Port').innerHTML='<input type=\'text\' name=\'LS[port]\' size=\'5\' value=\'{$port}\' style=\'text-align: center; font-weight: bold; width: 100%; border: 1px solid #EAEAEA; color: #666; box-shadow: 1px 3px 5px #EAEAEA inset; border-radius: 50px;\' />';" title="单击进行编辑"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span> {$port}</span>
                </td>
                <td style="width: 10%">{($upload / 1048576)|round:2} MB</td>
                <td style="width: 10%">{($download / 1048576)|round:2} MB</td>
                <td style="width: 10%">{($addition / 1048576)|round:2} MB</td>
                <td style="width: 15%">{((($traffic + $addition) - ($upload + $download)) / 1048576)|round:2} MB</td>
                <td style="width: 15%">{$method}</td>
                <td style="width: 15%">{$protocol}</td>
                <td style="width: 15%">{$obfs}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
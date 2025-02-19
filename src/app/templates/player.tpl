<div class="player-header-background vjs-control-bar">
    <i class="state-info-player fas fa-play" id="osd_play"></i>
    <i class="state-info-player fas fa-pause" id="osd_pause"></i>
    <div class="player-title"><%= title %></div>
    <div class="details-player">
        <% if(quality) { %>
        <span class="quality-info-player"><%= quality %></span>
        <% } %>
        <span class="fas fa-angle-down minimize-icon"></span>
        <span class="fas fa-times close-info-player"></span>
        <div class="download-info-player">
            <i class="fas fa-eye eye-info-player"></i>
            <div class="details-info-player">
                <div class="arrow-up"></div>
                <div id="sstatel-container"><br><span class="speed-info-player" id="sstatel"><%= i18n.__("Downloading") %></span></div><br>
                <div id="dwnloading"><span class="downloaded_player value">0</span></div><br>
                <span class="speed-info-player" id="dloaddd"><%= i18n.__("Download") %>:&nbsp;</span><span class="download_speed_player value"><%= Common.fileSize(0) %>/s</span><br>
                <span class="speed-info-player"><%= i18n.__("Upload") %>:&nbsp;</span><span class="upload_speed_player value"><%= Common.fileSize(0) %>/s</span><br>
                <span class="speed-info-player" id="apeersss"><%= i18n.__("Active Peers") %>:&nbsp;</span><span class="active_peers_player value">0<br></span>
                <% if(type !== 'video/youtube') { %>
                <% var filename; %>
                <span class="filename_player value"><%= i18n.__("Filename") %>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%= filename %></span><br>
                <span class="speed-info-player"><%= i18n.__("Stream Url") %>:&nbsp;</span><% if(src && Settings.ipAddress) { %><span class="stream_url_player value"><%= src.replace('127.0.0.1', Settings.ipAddress) %></span><% } %><br><br>
                <% } %>
            </div>
        </div>
    </div>
</div>
<div class="maximize-icon">
    <span class="downloadedPercent_player"></span>
    <span class="fas fa-pause" id="max_play_ctrl"></span>
    <span class="title"><%= title %></span>
    <span id="maxdllb">@ </span>
    <span class="download_speed_player" id="maxdl"></span>
    <span class="fa fa-angle-up tooltipped" id="maxic" data-toggle="tooltip" data-placement="top" title="<%= i18n.__("Restore") %>"></span>
</div>
<div class="trailer_mouse_catch"></div>
<div class="verify-metadata vjs-control-window">
    <div class="vm_poster">
        <img class="verifmeta_poster" src="images/posterholder.png">
    </div>
    <div class="vm_epinfo">
        <p class="verifmeta_show"></p>
        <p class="verifmeta_episode"></p>
        <p class="verifmeta_number"></p>
    </div>
    <div class="vm_box">
        <p class="verifmeta_boxtext"><%= i18n.__("Currently watching") %></p>
    </div>
    <div class="vm_btns">
        <div class="vm-btn verifmetaFALSE"><%= i18n.__("No, it's not that") %></div>
        <div class="vm-btn verifmetaTRUE"><%= i18n.__("Correct") %></div>
    </div>
</div>
<div class="playing_next vjs-control-window">
    <div class="pn_poster">
        <img class="playing_next_poster" src="images/posterholder.png">
    </div>
    <div class="pn_epinfo">
        <p class="playing_next_show"></p>
        <p class="playing_next_episode"></p>
        <p class="playing_next_number"></p>
    </div>
    <div class="pn_counter">
        <p class="playing_next_countertext"><%= i18n.__("Playing Next") %></p>
        <p id="nextCountdown">60</p>
    </div>
    <div class="pn_btns">
        <div class="auto-next-btn playnownextNOT"><%= i18n.__("No thank you") %></div>
        <div class="auto-next-btn playnownext"><%= i18n.__("Play Now") %></div>
    </div>
</div>
<%
    var subArray = [];
    for (var langcode in subtitle) {
        var langcodeName = langcode;
        var sequence = "";
        if(langcode.indexOf('|')!==-1){
            sequence = " "+langcode.substr(langcode.indexOf('|')+1);
            langcodeName = langcode.substr(0,langcode.indexOf('|'));
        }
        subArray.push({
            "language": langcode,
            "languageName": (App.Localization.langcodes[langcodeName] !== undefined ? App.Localization.langcodes[langcodeName].nativeName+sequence : langcodeName),
            "sub": subtitle[langcode]
        });
    }
    subArray.sort(function (sub1, sub2) {
        return sub1.languageName.localeCompare(sub2.languageName, undefined, {numeric: true, sensitivity: 'base'});
    });

    var subtracks = "";

    var defaultSub = "none";
    if (typeof defaultSubtitle != "undefined") {
        defaultSub = defaultSubtitle;
    }
    for(var index in subArray ) {
        var imDefault = "";

        if(defaultSub == subArray[index].language)
            imDefault = "default";

        subtracks += '<track kind="subtitles" src="' + subArray[index].sub + '" srclang="'+ subArray[index].language +'" label="' + subArray[index].languageName + '" charset="utf-8" '+ imDefault +' />';
    }
%>
<video id="video_player" width="100%" height="100%" class="video-js vjs-popcorn-skin" controls preload="auto" autoplay >
    <source src="<%= src %>" type="<%= type %>" />
    <%=subtracks%>
</video>

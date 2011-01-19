var vgid = 1;

function newLink(gid) {
    vgid = gid;
    $("#new_link_btn").trigger('click');
}

$(function () {
    $(".floor").sortable({
        revert: true,
        connectWith: '.floor',
        cursor: 'crosshair',
        update: function (event, ui) {
            $.ajax({
                type: 'post',
                data: '_method=put&' + $(this).sortable('serialize', {
                    key: 'floor[group_ids][]'
                }),
                dataType: 'json',
                url: '/floors/' + $(this).attr("fid")
            })
        }
    });
    $(".floor").disableSelection();

    $(".groups").each(function (i) {
        $(this).draggable({
            revert: true,
            revertDuration: 1000
        });
    });
    $("#wash").droppable({
        activeClass: 'wash-visit',
        hoverClass: 'wash-on',
        drop: function (event, ui) {
            $.ajax({
                type: "POST",
                cache: false,
                url: "/wash/" + ui.draggable.attr("gid"),
                success: function (data) {
                    var groupId = "#group-" + data;
                    var groupdiv = $(groupId);
                    if (groupdiv.length > 0) {
                        groupdiv.find("div:first").html("Group Name");
                        groupdiv.find("ul:first").html("")
                    } else {
                        alert("清空出错");
                    }
                }
            });
        }
    });
});

$(document).ready(function () {

    $("#link_url").change(function () {
        var re = /^(https|http)?:\/\/([^\/]+)(\/)?/i;
        var result = $("#link_url").val().match(re);
        var fav_url = "http://www.google.com/profiles/c/favicons?domain=" + result[2];
        $("#favimg").html('<img src="' + fav_url + '" />');
        $("#link_favicon_img").val(fav_url);
    });

    $(".column").hover(

    function () {
        if ($(this).attr("na") != '1' && $(this).find("a.link_add").length <= 0) {
            $(this).append($('<a class="link_add" OnClick="javascript:newLink(' + $(this).attr("gid") + ');return false;" href="#">+</a>'));
        }
    }, function () {
        $(this).find("a.link_add").remove();
    });

    $(".linkwp>li").hover(

    function () {
        if ($(this).parent().parent().attr("na") != '1' && $(this).find("a.link_del").length <= 0) {

            $(this).append($('<a href="/links/' + $(this).find("a:first").attr("lid") + '" data-confirm="确定删除?" data-method="delete" title="删除" class="link_del">-</a>'));
        }
    }, function () {
        $(this).find("a.link_del").remove();
    });

    $('li > a').click(function () {
        $.ajax({
            type: 'post',
            dataType: 'json',
            url: '/links/' + $(this).attr("lid") + '/hit'
        })
    });
    $("#new_link_btn").fancybox({
        'scrolling': 'no',
        'titleShow': false,
        'onClosed': function () {}
    });

    $("#new_link_form").bind("submit", function () {


        $.fancybox.showActivity();

        $.ajax({
            type: "POST",
            cache: false,
            url: "/groups/" + vgid + "/links.js",
            data: $(this).serializeArray(),
            success: function (data) {
                $.fancybox.close();
            }
        });

        return false;
    });

    $(".groupeditable").each(function (i) {
        $(this).editable('/groups/' + $(this).attr("gid") + '.name', {
            id: 'u',
            method: "PUT",
            name: 'group[name]',
            onblur: "ignore",
            cssclass: 'sl1',
            event: "dblclick",
            indicator: "saving..",
            tooltip: '双击进行编辑'
        })
    });
});
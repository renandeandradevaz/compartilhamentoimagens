$(document).ready(function () {

    $(".aceitarAmizade").on("click", function () {

        aceitarOuRecusarAmizade("aceitar_amizade", this);
    });

    $(".recusarAmizade").on("click", function () {

        aceitarOuRecusarAmizade("recusar_amizade", this);
    });

    $(".informe-nome-para-pesquisa").on("keyup", function () {

        $("#usuarios-pesquisados").empty();

        pesquisarUsuarios($("#metodo-auto-complete").val());
    });

    $("#botao-carregar-mais").on("click", function () {

        pesquisarUsuarios($("#metodo-carregar-mais").val());
    });

    $(window).scroll(function () {

        if ($(window).scrollTop() == $(document).height() - $(window).height()) {

            pesquisarUsuarios($("#metodo-carregar-mais").val());
        }
    });

});

function aceitarOuRecusarAmizade(metodo, botao) {

    var botaoClicado = $(botao);

    $.ajax({
        url: "/home/" + botaoClicado.parent().attr("id") + "/" + metodo,
        success: function (data) {
            botaoClicado.parent().remove();
        }
    });
}

function pesquisarUsuarios(metodo) {

    $("#botao-carregar-mais").hide();

    $.ajax({
        url: "/" + $("#controller").val() + "/" + metodo + "?id=" + $("#informe-nome-para-pesquisa").val(),
        success: function (data) {

            $(data.usuarios).each(function (i, usuario) {

                if (jQuery("#" + usuario.id).length == 0) {

                    $("#usuarios-pesquisados").append('<div>');
                    $("#usuarios-pesquisados").find('div:last').attr('id', usuario.id);
                    $("#usuarios-pesquisados").find('div:last').attr('onclick', "window.location='/perfil/" + usuario.atalho + "'");
                    $("#usuarios-pesquisados").find('div:last').addClass('col-md-4 usuario-pesquisa');
                    $("#usuarios-pesquisados").find('div:last').append('<img>');
                    $("#usuarios-pesquisados").find('div:last').find('img').addClass("foto-usuario-pesquisado img-thumbnail");
                    $("#usuarios-pesquisados").find('div:last').find('img').attr("src", usuario.url_avatar);
                    $("#usuarios-pesquisados").find('div:last').append('<p>');
                    $("#usuarios-pesquisados").find('div:last').find('p').append(usuario.name);

                    $("#botao-carregar-mais").show();
                }
            });
        }
    });
}


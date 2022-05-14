window.addEventListener('load', function() {
    console.log('Roda WeaponShop Started')
})

var weaponname = null 
var weaponprice = null
window.addEventListener('message', function(event) {
    var v = event.data

    switch(v.action) {
        case 'openShop':
                $('.contenedor').show(500)
                $('.Appendxd').append(`
                    <div class="Texto" id="${v.name}">
                        <h1>${v.label}</h1>
                    </div>
                `)
                $(`#${v.name}`).click(function(){
                    $('.NewWeapon').remove()
                    $.post('https://Roda_WeaponShop/RequestWeapons', JSON.stringify({
                        cat : v.name,
                    })); 
                })
        break;

        case 'AppendWeapons':
                $('.AppendWeapons').append(`
                    <div class="NewWeapon" id="${v.name}-click" tabindex=${v.numero}>
                    <h1>${v.label}</h1>
                    <div id="imgpe">
                        <img src="img/${v.name.toLowerCase()}.png" alt="">
                    </div>
                    <br><br><br><br>
                    <h1>Price: <span id="colorPe">${v.price}$</span></h1>
                    </div>
                `)
                $(`#${v.name}-click`).click(function(){
                    $.post('https://Roda_WeaponShop/RequestStats', JSON.stringify({
                        arma : v.name,
                    })); 
                    weaponname = v.name
                    weaponprice = v.price
                    $('.CenterWeapon').html(`
                        <div class="CenterWeaponChau">
                        <h1>${v.label}</h1>
                        <div class="ContImg">
                            <img src="img/${v.name.toLowerCase()}.png" alt="">
                        </div> 
                        </div>
                    `)
                })
        break;

        case 'showNoti': 
            ShowNoti(v.titulo, v.cuerpo, v.tipo)
        break;

        case 'ShowStats': 
            $('.BuyContainer').show(500)
            $('.RealBuyContainer').show(300)
            $('.damageBar').css('width', `${v.damage}%`)
            $('.AccuracyBar').css('width', `${v.accuracy}%`)
            $('.SpeedBar').css('width', `${v.speed}%`)
            $('.RangeBar').css('width', `${v.range}%`)
        break;
    }
})

$(function(){
    $('.fa-dollar-sign').click(function(){
        $.post('https://Roda_WeaponShop/BuyWeapon', JSON.stringify({
            arma : weaponname,
            price : weaponprice,
            tipo : 'money'
        })); 
    })  

    $('.fa-credit-card').click(function(){
        $.post('https://Roda_WeaponShop/BuyWeapon', JSON.stringify({
            arma : weaponname,
            price : weaponprice,
            tipo : 'bank'
        })); 
    })
})

$(document).keyup((e) => {
    
    if (e.key === "Escape") {
            $.post('https://Roda_WeaponShop/exit', JSON.stringify({}));
            CloseAll()
    }
});

function CloseAll(){
    $('.contenedor').hide(500)
    $('.Texto').remove()
    $('.BuyContainer').hide(500)
    $('.NewWeapon').remove()
    $('.RealBuyContainer').hide(500)
    $('.CenterWeaponChau').remove()
}
//Make close panel



function ShowNoti(title, cuerpo, tipo) {
    var sound = null;
    var id = $(`.NotisDaddy .notis`).length;
    $('.NotisDaddy').animate({'right':'1vw'})
    $('.NotisDaddy').show()
    if (tipo == 'success') {
        $('.NotisDaddy').append(`
        <div id=${id} class="notis"> 
            <h1><i class="fa-solid fa-gun"></i> ${title} </h1>
            <p>${cuerpo}</p>
        </div>
        `)
    } else if(tipo == 'error') {
        $('.NotisDaddy').append(`
        <div id=${id} class="notis"> 
            <h1><i class="fa-solid fa-hexagon-exclamation"></i> ${title} </h1>
            <p>${cuerpo}</p>
        </div>
        `)
    }

    if (tipo == 'error') {
        setTimeout(function(){
            if (sound != null) {
                sound.pause();
            }
    
            sound = new Howl({src: ['https://cdn.discordapp.com/attachments/961704227019837501/966728282437451786/error.mp3']});
            sound.volume(0.7);
            sound.play();
        }, 200)
    } else if (tipo == 'success') {
        setTimeout(function(){
            if (sound != null) {
                sound.pause();
            }
    
            sound = new Howl({src: ['https://cdn.discordapp.com/attachments/930160016525250621/975066649671630858/default.mp3']});
            sound.volume(0.7);
            sound.play();
        }, 200)
    }
    
    setTimeout(function () {
        var $this = $(`.NotisDaddy .notis[id=${id}]`);

        $this.fadeOut(400)
    }, 3000)
}
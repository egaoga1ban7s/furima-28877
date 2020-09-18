//price関数を定義
function price() {
  //要素を取得
  const item_price = document.getElementById("item-price")
  const add_tax_price = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")

  //イベント発火時の関数を定義
  item_price.addEventListener('keyup', () => {    //keyupイベント発火(キーが離れた時)で以下関数を実行
    let tax_value = item_price.value / 10;
    tax_value = parseInt(tax_value);              //小数点以下を切り捨て
    add_tax_price.innerHTML = tax_value;          //innerHTML関数を使い計算結果を出力
    let profit_value = item_price.value - tax_value;
    profit.innerHTML = profit_value;
  });
};
//画面ロード時に定義したprice関数を実行
window.addEventListener("load", price);
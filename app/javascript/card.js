const pay = () => {
  // 公開鍵の設定
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("charge-form");
  // フォームボタン押した際の処理
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    console.log(formResult)
    const formData = new FormData(formResult);
    console.log(formData)
    // 入力されたカードの情報を定数cardにハッシュ形式で代入
    const card = {
      number: formData.get("number"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
      cvc: formData.get("cvc"),
    }; 
    console.log(card);
    // カード情報を元にtokenを生成
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        console.log(token)
        console.log("OK")
      }else{
        console.log("NG")
      }
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name"); 
      console.log("1")

      document.getElementById("charge-form").submit();
      document.getElementById("charge-form").reset();
      console.log("2")
    });
  });
};
window.addEventListener("load", pay);

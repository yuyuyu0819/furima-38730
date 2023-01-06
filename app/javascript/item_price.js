window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", ()=> {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");
    // "入力した金額をもとに販売手数料を計算する処理"
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    // 出品から販売手数料を引く処理
    profitDom.innerHTML = Math.floor(inputValue - addTaxDom.innerHTML);
  })
});

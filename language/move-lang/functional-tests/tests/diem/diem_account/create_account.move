//! sender: blessed
script {
use 0x1::Coin1::Coin1;
use 0x1::DiemAccount;
use 0x1::LCS;
fun main(account: &signer) {
    let addr: address = 0x111101;
    assert(!DiemAccount::exists_at(addr), 83);
    DiemAccount::create_parent_vasp_account<Coin1>(account, addr, LCS::to_bytes(&addr), x"aa", false);
}
}

//! new-transaction
script {
use 0x1::Coin1::Coin1;
use 0x1::DiemAccount;
fun main(account: &signer) {
    let addr: address = 0x111101;
    let with_cap = DiemAccount::extract_withdraw_capability(account);
    DiemAccount::pay_from<Coin1>(&with_cap, addr, 10, x"", x"");
    DiemAccount::restore_withdraw_capability(with_cap);
    assert(DiemAccount::balance<Coin1>(addr) == 10, 84);
    assert(DiemAccount::sequence_number(addr) == 0, 84);
}
}

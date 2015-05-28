env = ENV

KEYPAIRS = [
  { label: "key_pvt_ssh_makevoid",      pvt: env["KEY_PVT_SSH_MAKEVOID"],      pub: "", type: :ssh },
  { label: "key_pvt_ssh_sys",           pvt: env["KEY_PVT_SSH_SYS"],           pub: "", type: :ssh },
  { label: "key_pvt_bitcoin_makevoid",  pvt: env["KEY_PVT_BITCOIN_MAKEVOID"],  pub: "", type: :bitcoin },
  { label: "key_pvt_bitcoin_sys",       pvt: env["KEY_PVT_BITCOIN_SYS"],       pub: "", type: :bitcoin },
  { label: "key_pvt_ssh_local",         pvt: "antani",                         pub: "", type: :ssh },
]

class Keypair
  # generate locally (type: btc/ssh/php)

  # add to server X
end

local cmd = vim.cmd

-- Do not comment new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

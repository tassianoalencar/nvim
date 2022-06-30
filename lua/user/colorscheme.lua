local present, themer = pcall(require, 'themer')

if not present then
  return
end

themer.setup({
  colorscheme = "rose_pine",
})

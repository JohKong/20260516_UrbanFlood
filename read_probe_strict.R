read_probe_strict <- function(file,
                              save_csv = FALSE,
                              out_dir = ".",
                              prefix = NULL) {
  # 读所有行
  lines <- readLines(file)
  
  # 找到 "# Time" 表头行
  i <- grep("^#\\s*Time", lines)
  if (length(i) != 1) {
    stop("未能唯一定位 '# Time' 表头行")
  }
  
  # 解析列名
  header <- sub("^#\\s*", "", lines[i])
  col_names <- strsplit(header, "\\s+")[[1]]
  
  # 读数据区
  dt <- fread(file, skip = i + 1, header = FALSE)
  
  # 赋列名
  setnames(dt, col_names)
  
  # ---------- 保存 CSV（可选） ----------
  if (isTRUE(save_csv)) {
    if (is.null(prefix)) {
      prefix <- basename(file)
    }
    
    if (!dir.exists(out_dir)) {
      dir.create(out_dir, recursive = TRUE)
    }
    
    out_file <- file.path(out_dir, paste0(prefix, ".csv"))
    fwrite(dt, out_file)
    
    message("CSV 已保存：", out_file)
  }
  
  return(dt)
}


Ux <- read_probe_strict("Ux", save_csv = TRUE)
Uy <- read_probe_strict("Uy", save_csv = TRUE)
Uz <- read_probe_strict("Uz", save_csv = TRUE)

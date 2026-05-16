from PIL import Image

def merge_images_horizontal(image_paths, output_path):
    # 1. 打开所有图片
    images = [Image.open(x) for x in image_paths]
    
    # 2. 计算总宽度和最大高度
    total_width = max(img.width for img in images)
    max_height = sum(img.height for img in images)
    
    # 3. 创建空白画布 (RGB 模式)
    new_img = Image.new('RGB', (total_width, max_height), (255, 255, 255))
    
    # 4. 依次粘贴
    current_height = 0
    for img in images:
        new_img.paste(img, (0, current_height))
        current_height += img.height

    # 5. 保存
    new_img.save(output_path)
    print(f"拼接完成！已保存至: {output_path}")

# 使用示例

merge_images_horizontal(['Fig6(a).jpg', 'Fig6(b).jpg', 'Fig6(c).jpg', 'Fig6(d).jpg'], 'Fig6.jpg')
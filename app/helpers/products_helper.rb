module ProductsHelper
  def image(product)
    default_cover = 'https://picsum.photos/200/200'

    image_tag product.pics.first || default_cover
  end
end

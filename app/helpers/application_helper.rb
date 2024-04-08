module ApplicationHelper
  def default_meta_tags(page_title = '')
    {
      site: 'TailTales',
      title: page_title.empty? ? '' : page_title.to_s,
      reverse: true,
      separator: '|',
      description: 'おすすめの犬種を診断します',
      canonical: request.original_url, # 優先するurlを指定する
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') }
      ],
      og: {
        site_name: 'TailTales',
        title: page_title.empty? ? 'TailTales' : "TailTales | #{page_title}",
        type: 'website',
        url: request.original_url,
        image: image_url('top_explain_block_04'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        image: image_url('top_explain_block_04')
      }
    }
  end
end

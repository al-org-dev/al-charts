require 'minitest/autorun'
require 'liquid'

require_relative '../lib/al_charts'

class AlChartsScriptsTagTest < Minitest::Test
  Site = Struct.new(:config)

  def render_scripts(config:, page: {})
    template = Liquid::Template.parse('{% al_charts_scripts %}')
    template.render({}, registers: { site: Site.new(config), page: page })
  end

  def third_party_libraries
    {
      'mermaid' => { 'url' => { 'js' => 'https://cdn.example/mermaid.js' }, 'integrity' => { 'js' => 'sha-mermaid' } },
      'd3' => { 'url' => { 'js' => 'https://cdn.example/d3.js' }, 'integrity' => { 'js' => 'sha-d3' } },
      'diff2html' => { 'url' => { 'js' => 'https://cdn.example/diff2html.js' }, 'integrity' => { 'js' => 'sha-diff' } },
      'leaflet' => { 'url' => { 'js' => 'https://cdn.example/leaflet.js' }, 'integrity' => { 'js' => 'sha-leaflet' } },
      'chartjs' => { 'url' => { 'js' => 'https://cdn.example/chart.js' }, 'integrity' => { 'js' => 'sha-chartjs' } },
      'echarts' => {
        'url' => { 'js' => { 'library' => 'https://cdn.example/echarts.js', 'dark_theme' => 'https://cdn.example/echarts-dark.js' } },
        'integrity' => { 'js' => { 'library' => 'sha-echarts', 'dark_theme' => 'sha-echarts-dark' } }
      },
      'plotly' => { 'url' => { 'js' => 'https://cdn.example/plotly.js' }, 'integrity' => { 'js' => 'sha-plotly' } },
      'vega' => { 'url' => { 'js' => 'https://cdn.example/vega.js' }, 'integrity' => { 'js' => 'sha-vega' } },
      'vega-lite' => { 'url' => { 'js' => 'https://cdn.example/vega-lite.js' }, 'integrity' => { 'js' => 'sha-vega-lite' } },
      'vega-embed' => { 'url' => { 'js' => 'https://cdn.example/vega-embed.js' }, 'integrity' => { 'js' => 'sha-vega-embed' } }
    }
  end

  def test_renders_mermaid_with_optional_zoom
    output = render_scripts(
      config: {
        'baseurl' => '/base',
        'third_party_libraries' => third_party_libraries
      },
      page: {
        'mermaid' => { 'enabled' => true, 'zoomable' => true }
      }
    )

    assert_includes output, 'https://cdn.example/mermaid.js'
    assert_includes output, 'https://cdn.example/d3.js'
    assert_includes output, '/base/assets/al_charts/js/mermaid-setup.js'
  end

  def test_renders_echarts_dark_theme_only_when_darkmode_enabled
    output = render_scripts(
      config: {
        'baseurl' => '/base',
        'enable_darkmode' => true,
        'third_party_libraries' => third_party_libraries
      },
      page: {
        'chart' => { 'echarts' => true }
      }
    )

    assert_includes output, 'https://cdn.example/echarts.js'
    assert_includes output, 'https://cdn.example/echarts-dark.js'
    assert_includes output, '/base/assets/al_charts/js/echarts-setup.js'
  end

  def test_renders_vega_plotly_and_leaflet
    output = render_scripts(
      config: {
        'baseurl' => '/base',
        'third_party_libraries' => third_party_libraries
      },
      page: {
        'map' => true,
        'chart' => { 'plotly' => true, 'vega_lite' => true }
      }
    )

    assert_includes output, 'https://cdn.example/leaflet.js'
    assert_includes output, 'https://cdn.example/plotly.js'
    assert_includes output, 'https://cdn.example/vega.js'
    assert_includes output, '/base/assets/al_charts/js/vega-setup.js'
  end

  def test_returns_empty_string_when_no_flags_set
    output = render_scripts(
      config: {
        'baseurl' => '/base',
        'third_party_libraries' => third_party_libraries
      },
      page: {}
    )

    assert_equal '', output
  end
end

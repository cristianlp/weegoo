Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "198486753523546", "909bdc979122add452c12045b0fa2412", { :scope => 'publish_stream,offline_access,email' }
  provider :twitter, "jvgcBXVYLJY2gpcwAAOHw", "Fpn4kfD3OgIEXlkmmAOWDBZrlRNqiTfK36e9lTdkOk"
end

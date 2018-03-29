module Spree
  class AnnexCloudUser < Spree::Base
    module Api
      def annex_cloud_get(url, params = {})
        response = HTTParty.get url, query: params.merge(access_token: SpreeAnnexCloud.configuration.access_token)
        return if response.blank?
        if response['errorcode'] == '0'
          response['data'].present? ? response['data'].with_indifferent_access : true
        else
          false
        end
      rescue StandardError
        nil
      end

      def annex_cloud_post(url, params = {})
        response = HTTParty.post url, query: params.merge(access_token: SpreeAnnexCloud.configuration.access_token)
        return if response.blank?

        response['errorcode'] == '0' ? response : false
      rescue StandardError
        nil
      end

      def api_user_url
        "#{SpreeAnnexCloud::ANNEX_CLOUD_API_BASE_URL}/user/#{SpreeAnnexCloud.configuration.site_id}/#{email}"
      end
    end
  end
end

module FbGraph
  module Connections
    module AdAccounts
      def ad_accounts(options = {})
        ad_accounts = self.connection :adaccounts, options
        ad_accounts.map! do |ad_account|
          AdAccount.new ad_account[:id], ad_account.merge(
            :access_token => options[:access_token] || self.access_token
          )
        end
      end

      def ad_account!(options)
        default_options = {
          :partner => 'NONE',
          :end_advertiser => 'NONE',
          :media_agency => 'NONE'
        }

        ad_account = post default_options.merge(options.merge(:connection => :adaccount))
        AdAccount.new ad_account[:id], ad_account.merge(
          :access_token => options[:access_token] || self.access_token
        )
      end
    end
  end
end


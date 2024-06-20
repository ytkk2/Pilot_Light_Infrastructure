# AWSを用いたWeb三層アーキテクチャのTerraform構築

このリポジトリは、AWSを用いてWeb三層アーキテクチャをTerraformで構築するための設定ファイルを含んでいます。構成はネットワーク、セキュリティ、ALB、EC2、RDS、Route53、CloudTrail、WAFモジュールを組み合わせて実現されています。

## 構成要素

### ネットワーク (network module)
- VPCの作成
- パブリックサブネットおよびプライベートサブネットの作成
- インターネットゲートウェイとNATゲートウェイの設定

### セキュリティ (security module)
- ALB、EC2、RDS用のセキュリティグループの作成
- 各セキュリティグループのルール設定

### ALB (alb module)
- Application Load Balancerの作成
- ターゲットグループとリスナーの設定
- EC2インスタンスとの関連付け

### EC2 (ec2 module)
- Webサーバー用のEC2インスタンスの作成
- オートスケーリンググループの設定
- DockerとWordPressのインストールスクリプトを含むユーザーデータの設定

### RDS (rds module)
- Maria DBのRDSインスタンスの作成
- DBサブネットグループの設定
- Secrets Managerを使用したDBパスワードの管理

### Route53 (route53 module)[^1]
- ホストゾーンの作成
- ALBのDNSエイリアスレコードの設定

[^1]:ご自身のドメイン名に変更して下さい

### CloudTrail (cloudtrail module)
- CloudTrailの設定
- S3バケットにログを保存
- バケットポリシーの設定

### WAF (waf module)
- Web ACLの作成
- レート制限ルールの設定（1分間に100リクエストを超えるIPをブロック）
- ALBへのWAF適用

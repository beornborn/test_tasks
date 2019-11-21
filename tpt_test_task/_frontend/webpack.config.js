var path = require('path')

module.exports = {
  entry: ['babel-polyfill', 'whatwg-fetch', './app/Root'],
  output: {
    path: path.join(__dirname, './dist'),
    publicPath: '/',
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: [/node_modules/],
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['react', 'env', 'stage-0']
          }
        }
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        use: ['file-loader?name=[path][name].[ext]']
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader', 'sass-loader']
      }
    ]
  },
  plugins: [],
  resolve: {
    extensions: ['.js', '.json', '.css'],
    modules: [path.join(__dirname, './app'), 'node_modules']
  }
}

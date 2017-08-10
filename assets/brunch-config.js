exports.config = {
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    assets: /^(static|semantic\/dist\/themes\/default\/assets)/
  },

  paths: {
    watched: [
      "static",
      "css",
      "js",
      "vendor",
      "semantic/dist/semantic.css",
      "semantic/dist/semantic.js",
      "semantic/dist/themes/default",
    ],
    public: "../priv/static"
  },

  plugins: {
    babel: {
      ignore: [/vendor/, /semantic/]
    },
    less: {
      dumpLineNumbers: 'comments'
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true,
    globals: {
      $: 'jquery',
      jQuery: 'jquery',
    },
  }
};

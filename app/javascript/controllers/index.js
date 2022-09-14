// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

import NamespaceController from "./namespace_controller"
import NamespacesController from "./namespaces_controller"

application.register("namespace", NamespaceController)
application.register("namespaces", NamespacesController)

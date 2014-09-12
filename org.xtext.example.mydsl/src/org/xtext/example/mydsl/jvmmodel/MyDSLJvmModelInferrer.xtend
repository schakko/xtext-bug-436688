package org.xtext.example.mydsl.jvmmodel

import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.xtext.resource.XtextResourceSet
import org.eclipse.xtext.xbase.jvmmodel.AbstractModelInferrer
import org.eclipse.xtext.xbase.jvmmodel.IJvmDeclaredTypeAcceptor
import org.eclipse.xtext.xbase.jvmmodel.JvmAnnotationReferenceBuilder
import org.eclipse.xtext.xbase.jvmmodel.JvmTypeReferenceBuilder
import org.eclipse.xtext.xbase.jvmmodel.JvmTypesBuilder
import org.xtext.example.mydsl.myDSL.DomainType
import org.xtext.example.mydsl.myDSL.Model
import org.xtext.example.mydsl.myDSL.PackageType

/**
 * <p>Infers a JVM model from the source model.</p> 
 *
 * <p>The JVM model should contain all elements that would appear in the Java code 
 * which is generated from the source model. Other models link against the JVM model rather than the source model.</p>     
 */
class MyDSLJvmModelInferrer extends AbstractModelInferrer {
	@Inject extension IQualifiedNameProvider

	extension JvmTypeReferenceBuilder jvmTypeReferenceBuilder

	extension JvmAnnotationReferenceBuilder jvmAnnotationReferenceBuilder

	@Inject def setJvmTypeReferenceBuilder(JvmTypeReferenceBuilder.Factory factory, XtextResourceSet resourceSet) {
		this.jvmTypeReferenceBuilder = factory.create(resourceSet)
	}

	@Inject def JvmAnnotationReferenceBuilder(JvmAnnotationReferenceBuilder.Factory factory,
		XtextResourceSet resourceSet) {
		this.jvmAnnotationReferenceBuilder = factory.create(resourceSet)
	}

	/**
     * convenience API to build and initialize JVM types and their members.
     */
	@Inject extension JvmTypesBuilder

	def dispatch void infer(Model element, IJvmDeclaredTypeAcceptor acceptor, boolean isPreIndexingPhase) {
		for (pkg : element.packages) {
			for (domain : pkg.domains) {
				domain.toClass(pkg.importedNamespace + ".entity." + domain.name,
					[
						addAnnotations(it, element.entityAnnotations)
						if (!domain.isWithoutEntityMapping) {
							var annotation_Entity = annotationRef("javax.persistence.Entity")
							annotations += annotation_Entity
						} else {
							documentation = "Some documentation"
						}
						var default_constructor = toConstructor[
							body = [
								append('''// default constructor''')
							]
						]
					])
			}
		}
	}
}

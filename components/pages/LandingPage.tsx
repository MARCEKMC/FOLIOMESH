'use client';

import { 
  UserGroupIcon, 
  GlobeAltIcon, 
  PaintBrushIcon,
  AcademicCapIcon,
  BriefcaseIcon,
  StarIcon,
  ArrowRightIcon,
  CheckIcon
} from '@heroicons/react/24/outline';

export function LandingPage() {
  const features = [
    {
      icon: PaintBrushIcon,
      title: "Customizable Portfolios",
      description: "Create stunning portfolios with 7 different sections and multiple design themes"
    },
    {
      icon: GlobeAltIcon,
      title: "Custom Subdomains",
      description: "Get your personal subdomain like yourname.foliomesh.com"
    },
    {
      icon: UserGroupIcon,
      title: "Professional Network",
      description: "Connect with professionals and companies in your industry"
    },
    {
      icon: BriefcaseIcon,
      title: "Job Opportunities",
      description: "Discover and apply to jobs that match your skills and experience"
    },
    {
      icon: AcademicCapIcon,
      title: "Skills Showcase",
      description: "Highlight your skills, projects, and achievements effectively"
    },
    {
      icon: StarIcon,
      title: "Premium Features",
      description: "Access advanced analytics, premium themes, and priority support"
    }
  ];

  const pricingPlans = [
    {
      name: "Free",
      price: "$0",
      period: "forever",
      features: [
        "1 Portfolio",
        "Basic Templates",
        "Custom Subdomain",
        "Basic Analytics",
        "Community Support"
      ],
      highlighted: false
    },
    {
      name: "Premium",
      price: "$9",
      period: "month",
      features: [
        "Unlimited Portfolios",
        "Premium Templates",
        "Advanced Analytics",
        "Priority Support",
        "3D Models Support",
        "Multiple Languages",
        "Custom Domain"
      ],
      highlighted: true
    }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-purple-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900">
      {/* Hero Section */}
      <section className="relative px-6 lg:px-8 pt-20 pb-16">
        <div className="mx-auto max-w-4xl text-center">
          <h1 className="text-4xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-6xl">
            Build Your Professional
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-purple-600"> Portfolio</span>
          </h1>
          
          <p className="mt-6 text-lg leading-8 text-gray-600 dark:text-gray-300">
            Create stunning portfolios, connect with professionals, and discover amazing job opportunities. 
            Join thousands of professionals showcasing their work on FolioMesh.
          </p>
          
          <div className="mt-10 flex items-center justify-center gap-x-6">
            <button className="rounded-md bg-blue-600 px-6 py-3 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 transition-colors flex items-center gap-2">
              Get Started Free
              <ArrowRightIcon className="h-4 w-4" />
            </button>
            <button className="text-sm font-semibold leading-6 text-gray-900 dark:text-white hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
              View Examples <span aria-hidden="true">→</span>
            </button>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-16 px-6 lg:px-8">
        <div className="mx-auto max-w-7xl">
          <div className="mx-auto max-w-2xl text-center">
            <h2 className="text-3xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-4xl">
              Everything you need to succeed
            </h2>
            <p className="mt-4 text-lg leading-8 text-gray-600 dark:text-gray-300">
              Powerful features to help you build, share, and grow your professional presence.
            </p>
          </div>
          
          <div className="mx-auto mt-16 max-w-2xl sm:mt-20 lg:mt-24 lg:max-w-none">
            <dl className="grid max-w-xl grid-cols-1 gap-x-8 gap-y-16 lg:max-w-none lg:grid-cols-3">
              {features.map((feature) => (
                <div key={feature.title} className="flex flex-col">
                  <dt className="flex items-center gap-x-3 text-base font-semibold leading-7 text-gray-900 dark:text-white">
                    <feature.icon className="h-5 w-5 flex-none text-blue-600" aria-hidden="true" />
                    {feature.title}
                  </dt>
                  <dd className="mt-4 flex flex-auto flex-col text-base leading-7 text-gray-600 dark:text-gray-300">
                    <p className="flex-auto">{feature.description}</p>
                  </dd>
                </div>
              ))}
            </dl>
          </div>
        </div>
      </section>

      {/* Pricing Section */}
      <section className="py-16 px-6 lg:px-8 bg-gray-50 dark:bg-gray-800/50">
        <div className="mx-auto max-w-7xl">
          <div className="mx-auto max-w-2xl text-center">
            <h2 className="text-3xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-4xl">
              Simple, transparent pricing
            </h2>
            <p className="mt-4 text-lg leading-8 text-gray-600 dark:text-gray-300">
              Choose the plan that's right for you. Start free, upgrade when you're ready.
            </p>
          </div>
          
          <div className="mx-auto mt-16 grid max-w-lg grid-cols-1 gap-y-6 sm:mt-20 sm:gap-y-0 lg:max-w-4xl lg:grid-cols-2">
            {pricingPlans.map((plan, index) => (
              <div
                key={plan.name}
                className={`flex flex-col justify-between rounded-3xl p-8 ring-1 ring-gray-200 dark:ring-gray-700 ${
                  plan.highlighted 
                    ? 'bg-blue-600 ring-blue-600 text-white lg:z-10 lg:order-2' 
                    : 'bg-white dark:bg-gray-900 text-gray-900 dark:text-white lg:order-1'
                } ${index === 1 ? 'lg:-mr-4' : ''}`}
              >
                <div>
                  <div className="flex items-center justify-between gap-x-4">
                    <h3 className={`text-lg font-semibold leading-8 ${
                      plan.highlighted ? 'text-white' : 'text-gray-900 dark:text-white'
                    }`}>
                      {plan.name}
                    </h3>
                    {plan.highlighted && (
                      <p className="rounded-full bg-blue-500 px-2.5 py-1 text-xs font-semibold leading-5 text-white">
                        Most popular
                      </p>
                    )}
                  </div>
                  <p className="mt-4 flex items-baseline gap-x-2">
                    <span className={`text-4xl font-bold tracking-tight ${
                      plan.highlighted ? 'text-white' : 'text-gray-900 dark:text-white'
                    }`}>
                      {plan.price}
                    </span>
                    <span className={`text-sm font-semibold leading-6 ${
                      plan.highlighted ? 'text-blue-200' : 'text-gray-600 dark:text-gray-400'
                    }`}>
                      /{plan.period}
                    </span>
                  </p>
                  <ul role="list" className="mt-8 space-y-3 text-sm leading-6">
                    {plan.features.map((feature) => (
                      <li key={feature} className="flex gap-x-3">
                        <CheckIcon 
                          className={`h-6 w-5 flex-none ${
                            plan.highlighted ? 'text-blue-200' : 'text-blue-600'
                          }`} 
                          aria-hidden="true" 
                        />
                        {feature}
                      </li>
                    ))}
                  </ul>
                </div>
                <button
                  className={`mt-8 block w-full rounded-md px-3.5 py-2.5 text-center text-sm font-semibold focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 transition-colors ${
                    plan.highlighted
                      ? 'bg-white text-blue-600 hover:bg-gray-100 focus-visible:outline-white'
                      : 'bg-blue-600 text-white hover:bg-blue-500 focus-visible:outline-blue-600'
                  }`}
                >
                  Get started
                </button>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-16 px-6 lg:px-8">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="text-3xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-4xl">
            Ready to showcase your work?
          </h2>
          <p className="mt-4 text-lg leading-8 text-gray-600 dark:text-gray-300">
            Join thousands of professionals who trust FolioMesh to showcase their work and advance their careers.
          </p>
          <div className="mt-10 flex items-center justify-center gap-x-6">
            <button className="rounded-md bg-blue-600 px-6 py-3 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 transition-colors">
              Create Your Portfolio
            </button>
          </div>
        </div>
      </section>
    </div>
  );
}
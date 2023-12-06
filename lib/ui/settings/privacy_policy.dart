import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ptsd_free/ui/home_screen.dart';
import 'package:ptsd_free/widgets/custom_colored_text.dart';
import 'package:ptsd_free/widgets/custom_text.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canpop) {
        // context.go("/home", extra: 3);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(currentIndex: 3)));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#23C4F1"),
          leading: IconButton(
              onPressed: () {
                // context.go("/home", extra: 3);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(currentIndex: 3)));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
              )),
          title: CustomColoredText(
              text: "Privacy Policy",
              hexColor: "#FFFFFF",
              size: 22,
              weight: 500),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                CustomColoredText(
                  text:
                      "THIS IS A LEGAL AGREEMENT BETWEEN YOU AND STRESS IS GONE, INC. THESE TERMS GOVERN YOUR USE OF ANY AND ALL OF STRESS IS GONE PRODUCTS AND/OR SERVICES. TO AGREE TO THESE TERMS, CLICK \"I AGREE.\" IF YOU DO NOT AGREE TO THESE TERMS, DO NOT CLICK \"I AGREE,\" AND DO NOT USE THE PRODUCTS AND SERVICES PROVIDED. YOU MUST ACCEPT AND ABIDE BY THESE TERMS AS PRESENTED TO YOU: CHANGES, ADDITIONS, OR DELETIONS ARE NOT ACCEPTABLE, AND STRESS IS GONE REFUSES YOUR ACCESS TO ANY AND ALL PRODUCTS AND SERVICES FOR NONCOMPLIANCE WITH ANY PART OF THIS AGREEMENT.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Definition of Stress Is Gone Products and Services: Stress Is Gone, Inc. provides the products and services offered on the Stress Is Gone website. Products include anything downloaded from our website, and/or viewed and/or heard on our website. Services include any and all types of stress elimination sessions (including Corporate, Academic, Public, Private, Individual, Phone, etc.), workshops, events, tele-classes and mentoring programs. You fully and completely understand the Stress Is Gone Products and/or Services are not a replacement or substitute for any type of therapy and/or prescription drugs. You fully and completely understand the Stress Is Gone Products and/or Services are coaching exercises that may or may not result in alleviating your stress. You agree that Stress Is Gone has no liability regarding your experience with the Stress Is Gone Products and/or Services in any way.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "System Requirements: Use of the Stress Is Gone website, products and/or services requires you to have certain technology and existing services. Because the use of what we offer involves your existing hardware, software, Internet access, and telephone service your ability to use our products and services may be affected by the performance of these factors on your end. High speed Internet access is strongly recommended. You acknowledge and agree that the system requirements are your responsibility. The Stress Is Gone Products and Services are not part of any other product or offering, and no purchase or rental or obtaining of any other product shall be construed to represent or guarantee you access to the Service.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Terms of Sale: Any and all purchases are final. There is no refund policy. Placing your mouse over the “Buy Now” button will initiate your purchasing process. Stress Is Gone accepts Visa, MasterCard credit cards and payment through your PayPal account. If the total amount of the transaction is greater than the balance available in your PayPal account or credit card, your PayPal account or credit card will be charged for the balance of the transaction. Debit cards and check cards have daily spending limits that may prevent the processing of your order. If a transaction has been declined online due to credit card issues, or issues with your PayPal account, please ensure all data is correct and resubmit. If the transaction is not accepted online, you will be unable to use that card or your PayPal account for the transaction and should use another credit card. Sales tax will be added to all transactions on the Stress Is Gone website based on the bill-to address and the sales tax rate in effect at the time your transaction is completed. We only charge tax in states where our products and services are taxable. No customers are eligible for tax exemptions for transactions made on the Stress Is Gone website. All Gift Certificate purchases are non-refundable. Sales tax is not charged when the Gift Certificate is purchased but when it is used for a transaction on the Stress Is Gone website. The tax rate of the transaction is based on the state of the Gift Certificate redeemer. Gift Certificates may not be used to purchase other Gift Certificates. Gift Certificates purchased on the Stress Is Gone website may only be purchased for, and redeemed by, residents of the United States. The Stress Is Gone website looks to offer you competitive prices on current selections. Your total price will include the price of the products and/or services of your selection plus any applicable sales tax. Stress Is Gone reserves the right to change prices for Products offered on the Stress Is Gone website at any time, and does not provide price protection or refunds in the event of a price drop or promotional offering. Stress Is Gone reserves the right to change content options without notice. On occasion, a product may become unavailable following a transaction but prior to download. Your sole remedy in such cases is a refund of the price paid for the unavailable product. Please contact Stress Is Gone through our website in these cases. Stress Is Gone reserves the right to change the terms and conditions of sale at any time. Customers are encouraged to review the Terms of Sale on a periodic basis for modifications. Risk of loss and title for all electronically delivered transactions pass to you upon electronic transmission to you. No Stress Is Gone employee or contractor has the authority to vary any of the Stress Is Gone policies or the terms and conditions governing any sale. You agree to pay for all Products and/or Services you purchase through the website, and that Stress Is Gone may charge your credit card or PayPal account for any Products and/or Services purchased, and for any additional amounts (including any taxes) as may be accrued by or in connection with your Account. You are responsible for the timely payment of all fees and for providing Stress Is Gone with a valid credit card or Paypal account details for payment of all fees. All fees will be billed to the credit card, or the PayPal account, you designate during the registration process. In the event you wish to change your payment method, there may be a temporary disruption of your access to the Products and/or Service until Stress Is Gone can verify the validity of the new payment method. Stress Is Gone has the Right to Change Prices and Availability of Products at any time. Regarding Electronic Signatures and Contracts, your use of the Stress Is Gone Products and/or Services includes the ability to enter into agreements and/or to make transactions electronically. YOU ACKNOWLEDGE THAT YOUR ELECTRONIC SUBMISSIONS CONSTITUTE YOUR AGREEMENT AND INTENT TO BE BOUND BY AND TO PAY FOR SUCH AGREEMENTS AND TRANSACTIONS. YOUR AGREEMENT AND INTENT TO BE BOUND BY ELECTRONIC SUBMISSIONS APPLIES TO ALL RECORDS RELATING TO ALL TRANSACTIONS YOU ENTER INTO ON THIS SITE, INCLUDING NOTICES OF CANCELLATION, POLICIES, CONTRACTS, AND APPLICATIONS. On occasion, technical problems may delay or prevent delivery of your Products and/or activation of your services. Your exclusive and sole remedy will be either replacement of the Product, or refund of the price paid for the Product and/or Services, as determined by Stress Is Gone.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Notices of Cancellation for Users: For individuals that purchase a coaching package, if cancellation does not occur more than 48 hours before a scheduled session, any missed session will be counted as a complete session and will be deducted from your plan. For individuals enrolled in a classes plan, if cancellation does not occur more than 48 hours before a scheduled class, any missed class will be counted as a completed class and will be deducted from your plan.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Usage Rules: You agree that your purchase of Stress Is Gone Products and/or Services constitutes your acceptance of and agreement to use such Products and/or Services solely in accordance with the Usage Rules, and that any other use of the Products and/or Services may constitute a copyright infringement. The Usage Rules shall govern your rights with respect to the Stress Is Gone Products and/or Services. Stress Is Gone reserves the right to modify the Usage Rules at any time. Your use and access to any and all Stress Is Gone Products and/or Services is conditioned upon your prior acceptance of the terms of this Agreement. You shall be authorized to use the Products and/or Services only for personal, noncommercial use. You shall be authorized to reproduce Stress Is Gone Products for your personal use and not to distribute to any other person for any other reason. Any reproduction or exporting capabilities are solely an accommodation to you and shall not constitute a grant or waiver of any rights of the copyright owners in any audio or video content, sound recording, underlying musical composition, or artwork embodied in any and all Stress Is Gone Products and/or Services. You agree that you will not attempt to, or encourage or assist any other person to, circumvent or modify any Usage Rules. The delivery of Products and/or Services does not transfer to you any commercial or promotional use rights of any and all of the Stress Is Gone Products and/or Services. Members who actively participate by speaking during a Stress Is Gone class, podcast and/or webinar agree to allow their voice and/or physical image to be recorded and used in the future as Stress Is Gone sees fit. You understand that by using the Stress Is Gone Service and/or Products, you may encounter content that may be deemed offensive, indecent, or objectionable, or contrary to your beliefs, which content may or may not be identified as having explicit language. Nevertheless, you agree to use the Products and/or Services at your sole risk and that Stress Is Gone shall have no liability to you for content that may be found to be offensive, indecent, or objectionable. The description of our products and/or services are provided for convenience, and you acknowledge and agree that Stress Is Gone does not guarantee their accuracy.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Interactive Features: Stress Is Gone may choose to offer interactive features that allow you to submit or post information, materials or links to third party content viewable by other users of the Products and/or Services and the public. You represent and agree that any use by you of such features, including any information, materials or links submitted or posted by you, shall be your sole responsibility, shall not infringe or violate the rights of any other party or violate any laws, contribute to or encourage infringing or otherwise unlawful conduct, or otherwise be obscene, objectionable or in poor taste, and that you have obtained all necessary rights, licenses or clearances. You further agree to provide accurate and complete information in connection with your submission or posting of any information or materials on the Service. Moreover, you hereby grant Stress Is Gone a worldwide, royalty-free, non-exclusive license to use such materials as part of The Stress Is Gone Product Line and/or Services, and in relation to Products, without any compensation or obligation to you. Stress Is Gone reserves the right not to post or publish any materials, and to delete, remove or edit any material, at any time in its sole discretion without notice or liability. Stress Is Gone has the right, but not the obligation, to monitor any information and materials submitted or posted by you or otherwise available on the Service, to investigate any reported or apparent violation of this Agreement, and to take any action that Stress Is Gone deems appropriate.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Intellectual Property: You agree that the Products and/or Services that is owned by Stress Is Gone and/or its licensors, and is protected by applicable intellectual property and other laws, including but not limited to copyright, trademark, trade secret and patent laws, and that you will not use such proprietary information or materials in any way whatsoever except for use of the Products and/or Services in compliance with the terms of this Agreement. No portion of the Products and/or Services may be reproduced in any form or by any means. You agree not to modify, rent, lease, loan, sell, distribute, or create derivative works based on the Products and/or Services, in any manner, and you shall not exploit the Products and/or Services in any unauthorized way whatsoever. BREAKING THE USAGE RULES DESCRIBED IN THIS AGREEMENT WHILE USING THESE PRODUCTS AND/OR SERVICES, IS STRICTLY PROHIBITED AND INFRINGES ON THE INTELLECTUAL PROPERTY RIGHTS OF OTHERS AND MAY SUBJECT YOU TO CIVIL AND CRIMINAL PENALTIES, INCLUDING POSSIBLE MONETARY DAMAGES, FOR COPYRIGHT INFRINGEMENT. Any Stress Is Gone trademarks, service marks, graphics, and logos used in connection with the Products and/or Services are trademarks or registered trademarks of Stress Is Gone. Other trademarks, service marks, graphics, and logos used in connection with the Products and/or Services may be the trademarks of their respective owners. You are granted no right or license with respect to any of such trademarks. As a user of the Products and/or Services Stress Is Gone may provide you with limited access to download certain artwork for Products and/or Services. Such access is provided as an accommodation only, and Stress Is Gone does not warrant or endorse and does not assume and will not have any liability or responsibility for such artwork or your use. You may only access artwork for Products and/or Services, which you are the lawful owner of a legal copy. Artwork is provided for personal, noncommercial use only. You agree that you will not use artwork in any manner that would infringe or violate these Terms of Service or the rights of any other party, and that Stress Is Gone is not in any way responsible for any such use by you.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Products Requirements: You acknowledge that use of Products and/or Services may require the use of other hardware and software products, and that such hardware and software is your responsibility. Once a Product and/or Service is purchased and you receive the Product, it is your responsibility not to lose, destroy, or damage the Product and /or Service, and Stress Is Gone shall be without liability to you in the event of any loss, destruction, or damage. You acknowledge that some aspects of the Stress Is Gone Product line and/or Service may change from time to time. Stress Is Gone may do this at its own election, you acknowledge that you may no longer be able to use certain Products and/or Services to the same extent as prior to such changes and that Stress Is Gone shall have no liability to you in such case. Certain content, products, and services available via Stress Is Gone may include materials from third parties. Stress Is Gone may provide links to certain third party Web sites. You acknowledge and agree that Stress Is Gone is not responsible for examining or evaluating the content or accuracy of any such third-party material or Web sites. Stress Is Gone does not warrant or endorse and does not assume and will not have any liability or responsibility for any third-party materials or Web sites, or for any other materials, products, or services of third parties. Links to other Web sites are provided solely as a convenience to you. You agree that you will not use any third-party materials in a manner that would infringe or violate the rights of any other party, and that Stress Is Gone is not in any way responsible for any such use by you. STRESS IS GONE DOES NOT GUARANTEE, REPRESENT, OR WARRANT THAT YOUR USE OF THE SERVICE WILL BE UNINTERRUPTED OR ERROR-FREE, AND YOU AGREE THAT FROM TIME TO TIME STRESS IS GONE MAY REMOVE THE SERVICE FOR INDEFINITE PERIODS OF TIME, OR CANCEL THE SERVICE AT ANY TIME, WITHOUT NOTICE TO YOU. YOU EXPRESSLY AGREE THAT YOUR USE OF, OR INABILITY TO USE, THE SERVICE IS AT YOUR SOLE RISK. THE SERVICE AND ALL PRODUCTS AND SERVICES DELIVERED TO YOU THROUGH THE SERVICE ARE PROVIDED 'AS IS' AND 'AS AVAILABLE' FOR YOUR USE, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND NONINFRINGEMENT. BECAUSE SOME JURISDICTIONS DO NOT ALLOW THE EXCLUSION OF IMPLIED WARRANTIES, THE ABOVE EXCLUSION OF IMPLIED WARRANTIES MAY NOT APPLY TO YOU. IN NO CASE SHALL STRESS IS GONE, ITS DIRECTORS, OFFICERS, EMPLOYEES, AFFILIATES, AGENTS, CONTRACTORS, OR LICENSORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, PUNITIVE, SPECIAL, OR CONSEQUENTIAL DAMAGES ARISING FROM YOUR USE OF ANY OF THE PRODUCTS AND/OR SERVICES OR FOR ANY OTHER CLAIM RELATED IN ANY WAY TO YOUR USE OF THE PRODUCTS AND/OR SERVICES, INCLUDING, BUT NOT LIMITED TO, ANY ERRORS OR OMISSIONS IN ANY CONTENT, OR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT (OR PRODUCT) POSTED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE PRODUCT AND/OR SERVICES, EVEN IF ADVISED OF THEIR POSSIBILITY. BECAUSE SOME STATES OR JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR THE LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES, IN SUCH STATES OR JURISDICTIONS, STRESS IS GONE’S LIABILITY SHALL BE LIMITED TO THE EXTENT PERMITTED BY LAW. STRESS IS GONE SHALL USE REASONABLE EFFORTS TO PROTECT INFORMATION SUBMITTED BY YOU IN CONNECTION WITH THE PRODUCTS AND/OR SERVICES, BUT YOU ACKNOWLEDGE AND AGREE THAT YOUR SUBMISSION OF SUCH INFORMATION IS AT YOUR SOLE RISK, AND STRESS IS GONE HEREBY DISCLAIMS ANY AND ALL LIABILITY TO YOU FOR ANY LOSS OR LIABILITY RELATING TO SUCH INFORMATION IN ANY WAY. STRESS IS GONE DOES NOT REPRESENT OR GUARANTEE THAT THE SERVICE WILL BE FREE FROM LOSS, CORRUPTION, ATTACK, VIRUSES, INTERFERENCE, HACKING, OR OTHER SECURITY INTRUSION, AND STRESS IS GONE DISCLAIMS ANY LIABILITY RELATING THERETO. YOU SHALL BE RESPONSIBLE FOR BACKING UP YOUR OWN SYSTEM, INCLUDING ANY SERVICES AND/OR PRODUCTS PURCHASED FROM STRESS IS GONE THAT ARE STORED IN YOUR SYSTEM. You recognize and agree your purchase of any and all of Stress Is Gone Products and/or Services are for your use and STRESS IS GONE does not guarantee your stress will be alleviated by using Stress Is Gone Products and/or Services (with exception to the guarantee clause for the first Corporate Stress Elimination Session or the first Corporate Stress Is Gone Introduction Class). You fully agree that Stress Is Gone is not liable for your discomfort, dissatisfaction, stress, perceived increase of stress, or any damages suffered in any way, shape or form from utilizing any and all of the Stress Is Gone Products and/or Services.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Termination by Stress Is Gone: If you fail, or Stress Is Gone suspects that you have failed, to comply with any of the provisions of this Agreement, Stress Is Gone, at its sole discretion, without notice to you may: (i) terminate this Agreement and/or your Account, and you will remain liable for all amounts due under your Account up to and including the date of termination. Stress Is Gone reserves the right to modify, suspend, or discontinue providing you access to its Products and/or Services at any time with or without notice to you, and Stress Is gone will not be liable to you or to any third party should it exercise such rights. The Service is controlled and operated by Stress Is Gone from its offices in the United States. You agree to comply with all local, state, federal, and national laws, statutes, ordinances, and regulations that apply to your use of Stress Is Gone Products and Services.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Stress Is Gone reserves the right to takes steps Stress Is Gone believes are reasonably necessary to enforce and/or verify compliance with any part of this Agreement (including but not limited to Stress Is Gone's right to cooperate with any legal process relating to your use of the Service and/or Products, and/or a third party claim that your use of the Service and/or Products is unlawful and/or infringes such third party's rights). You agree that Stress Is Gone has the right, without liability to you, to disclose any Registration Data and/or Account information to law enforcement authorities, government officials, and/or a third party, as Stress Is Gone believes is reasonably necessary or appropriate to enforce and/or verify compliance with any part of this Agreement (including but not limited to Stress Is Gone’s right to cooperate with any legal process relating to your use of the Service and/or Products, and/or a third party claim that your use of the Service and/or Products is unlawful and/or infringes such third party's rights).",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Indemnity : By using the service, you agree to indemnify and hold Stress Is Gone, its directors, officers, employees, affiliates, agents, contractors, and licensors harmless with respect to any claims arising out of your breach of this agreement, your use of the Stress Is Gone Product Line and/or Services, or any action taken by Stress Is Gone as part of its investigation of a suspected violation of this agreement or as a result of its finding or decision that violations of this agreement has occurred. This means that you cannot sue or recover any damages from Stress Is Gone, its directors, officers, employees, affiliates, agents, contractors, and licensors, as a result of its decision to remove or refuse to process any information or content, to warn you, to suspend or terminate your access to the service, or to take any other action during the investigation of a suspected violation or as a result of Stress Is Gone’s conclusion that a violation of this agreement has occurred. This waiver and indemnity provision applies to all violations described in or contemplated by this agreement.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Institutional responsibility: If you are procuring Stress Is Gone Products and/ Services for your organization and/or institution through the Stress Is Gone Corporate and/or Academic Solution, you completely understand and agree your organization is fully responsible for each user upholding ALL the terms and conditions within this agreement. You are responsible and liable for enforcing this agreement with your users. Furthermore you understand and agree to, if individuals within your organization wish to receive Stress Is Gone emails and/or purchase Stress Is Gone Products and/or Services on their own (through a personal email account) they are free to do so. Furthermore you understand and agree to, in cases of individuals from your organization and/or institution seeking to utilize Stress Is Gone Products and/or Services on their own, said individuals automatically take on all liability for their own use of any Stress Is Gone Products and/or Services. Stress Is Gone and/or your organization and/or your institution will never be held liable for any experience or assistance any individual privately seeks out regarding any and all Stress Is Gone Products and/or Services.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "Choice of Law: The laws of the State of New York, excluding its conflicts of law rules, govern these Terms of Service and your use of the Stress Is Gone Product Line and Services, including all transactions on the Stress is Gone website. Your use may also be subject to other local, state, national, or international laws. You expressly agree that exclusive jurisdiction for any claim or dispute with Stress Is Gone or relating in any way to your use of the Service resides in the courts of the State of New York.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
                CustomColoredText(
                  text:
                      "FINAL AGREEMENT: These Terms of Service constitute the agreement between you and Stress Is Gone, Inc. and govern your use of the Products and/or Services, superseding any prior agreements between you and Stress Is Gone, whether written or oral. You also may be subject to additional terms and conditions that may apply when you use affiliate services, third-party content, or third-party software. If any part of these Terms of Service is held invalid or unenforceable, that portion shall be construed in a manner consistent with applicable law to reflect, as nearly as possible, the original intentions of the parties, and the remaining portions shall remain in full force and effect. Stress Is Gone’s failure to enforce any right or provisions in these Terms of Service will not constitute a waiver of such provision, or any other provision of these Terms of Service. If any provision of this Agreement is found by a court of competent jurisdiction to be invalid, the other provisions will remain in full force and effect. Stress Is Gone will not be responsible for failures to fulfill any obligations due to causes beyond its control.",
                  hexColor: "#2C3351",
                  size: 14,
                  weight: 400,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
